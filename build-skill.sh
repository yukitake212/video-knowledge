#!/usr/bin/env bash
# video-knowledge → Skill / ChatGPT用ナレッジ をビルドする
#
# 使い方：リポジトリのルートで  ./build-skill.sh
#
# 出力：
#   dist/video-knowledge.zip     claude.ai の Customize > Skills へアップロード
#   dist/skill/                  参照をコピーで持つ版（配布用）
#   dist/skill-local/            参照を絶対パスで指す版（このマシンの Claude Code 用）
#   dist/chatgpt/                ChatGPT のプロジェクト指示＋ナレッジ
#
# オプション：
#   --with-private   video-projects/genres/*.md への絶対パスを skill-local にだけ埋める。
#                    zip と ChatGPT 版には入れない（クライアント案件の記述を含むため）。
#
# reference/ は手で編集しない。ここで毎回作り直す。正本は principles/ 等。
#
# 前提：GNU find と bash 4.4+。macOS の標準環境では、フラット化の衝突検査
#       （find -printf）と mapfile -d が動かない。

set -euo pipefail
cd "$(dirname "$0")"

SRC_SKILL="skill/SKILL.md"
DIST="dist"
REPO_ROOT="$(pwd)"
PRIVATE_ROOT="${PRIVATE_ROOT:-$(cd .. && pwd)/video-projects}"
WITH_PRIVATE=0

for arg in "$@"; do
  case "$arg" in
    --with-private) WITH_PRIVATE=1 ;;
    *) echo "エラー: 不明な引数: $arg" >&2; exit 1 ;;
  esac
done

die() { echo "エラー: $*" >&2; exit 1; }

# --- 前提チェック ---------------------------------------------------------
[ -f "$SRC_SKILL" ] || die "$SRC_SKILL が無い"
command -v zip >/dev/null || die "zip が入っていない"
command -v git >/dev/null || die "git が入っていない"
git rev-parse --git-dir >/dev/null 2>&1 || die "gitリポジトリの中で実行すること"

if [ "$WITH_PRIVATE" -eq 1 ]; then
  [ -d "$PRIVATE_ROOT/genres" ] || die "--with-private だが $PRIVATE_ROOT/genres が無い（PRIVATE_ROOT で上書き可）"
fi

if [ -n "$(git status --porcelain --untracked-files=no)" ]; then
  echo "警告: コミットされていない変更がある。ビルド情報が実態とずれる。"
  read -r -p "続ける? [y/N] " a; [ "$a" = "y" ] || exit 1
fi

HASH="$(git rev-parse --short HEAD)"
DATE="$(date +%Y-%m-%d)"
SUBJECT="$(git log -1 --pretty=%s)"

# --- リファレンスに入れるもの --------------------------------------------
# 除外：CHANGELOG.md（履歴は制作時に不要）／DIFF-FORMAT.md（受け渡し用）
#       CLAUDE.md・README.md（リポジトリ作業用）／genres/（実体はprivate）
DIRS=(principles templates platforms)
EXTRA=(OPERATIONS.md)

# --- ユーティリティ -------------------------------------------------------

# フロントマターを外す。無い場合は全文を返す。閉じていない場合はエラーで止める。
#   パイプを使わない。grep -q は先頭マッチで即終了するため、pipefail 下では
#   上流の tail が SIGPIPE(141) を受け、pipeline が失敗扱いになる。
#   閉じているのに「閉じていない」と誤判定する（SKILL.md が 128KB 付近で発火）。
strip_frontmatter() {
  local f=$1
  [ "$(head -n 1 "$f")" = "---" ] || { cat "$f"; return; }
  awk 'NR>1 && /^---$/{found=1; exit} END{exit !found}' "$f" \
    || die "$f のフロントマターが閉じていない"
  sed '1,/^---$/d' "$f"
}

# マーカーをリテラル置換する。
#   awk の gsub は置換文字列中の & を「マッチした文字列」に展開するので index/substr で行う。
#   値は -v ではなく ENVIRON で渡す。-v はエスケープシーケンスを解釈するため、
#   コミット件名の "C:\temp" が "C:<TAB>emp" になる。
inject_marker() {
  local marker=$1 value=$2
  MARKER="$marker" VALUE="$value" awk '
    BEGIN { m = ENVIRON["MARKER"]; v = ENVIRON["VALUE"]; n = length(m) }
    { while ((i = index($0, m)) > 0)
        $0 = substr($0, 1, i-1) v substr($0, i + n)
      print }
  '
}

# sed の置換文字列に使う文字列をエスケープする（& は「マッチした文字列」に展開される）
esc_repl() { printf '%s' "$1" | sed 's/[&|\]/\&/g'; }

# ディレクトリ内の .md を配列で取る。0件ならスキップ（cp の引数ゼロで落ちるため）
collect_md() {
  local d=$1
  find "$d" -maxdepth 1 -name '*.md' -type f -print0
}

# --- 鮮度についての文言 ---------------------------------------------------
FRESH_DIST="正本は GitHub の video-knowledge リポジトリ。このSkillはそこからビルドした成果物なので、
上のビルド情報より新しい変更は入っていない。**食い違ったらリポジトリが正しい。**"

FRESH_LOCAL="**参照先はリポジトリ本体なので常に最新。** 上のビルド情報は、このSKILL.md自体を
生成した時点を示すもので、参照先の鮮度とは関係しない。"

# ジャンル別ファイルの案内。**配布版には絶対パスを埋めない。**
GENRES_PUBLIC="  → **private（video-projects）にある。このSkillには入っていない。**
    ユーザーに聞くか、該当ファイルを貼ってもらう"

GENRES_LOCAL="$GENRES_PUBLIC"
if [ "$WITH_PRIVATE" -eq 1 ]; then
  GENRES_LOCAL="  → private のジャンル別ファイルを直接読む（このマシンのローカル版のみ）："
  while IFS= read -r g; do
    GENRES_LOCAL="$GENRES_LOCAL
    - \`$g\`"
  done < <(find "$PRIVATE_ROOT/genres" -maxdepth 1 -name '*.md' -type f ! -name 'README.md' | sort)
  GENRES_LOCAL="$GENRES_LOCAL
    どのジャンルにも当てはまらなければ飛ばす。**内容を public 側へ書き戻さない**"
fi

STAMP="**ビルド元：** \`${HASH}\`（${DATE}）／直近のコミット：${SUBJECT}"

# --- 1. Claude 用（配布版：参照をコピーで持つ）---------------------------
rm -rf "$DIST"
mkdir -p "$DIST/skill/reference"

for d in "${DIRS[@]}"; do
  [ -d "$d" ] || continue
  mapfile -d '' -t files < <(collect_md "$d")
  if [ "${#files[@]}" -eq 0 ]; then
    echo "注意: $d に .md が無い。スキップした"
    continue
  fi
  mkdir -p "$DIST/skill/reference/$d"
  cp "${files[@]}" "$DIST/skill/reference/$d/"
done

for f in "${EXTRA[@]}"; do
  if [ -f "$f" ]; then cp "$f" "$DIST/skill/reference/"; else echo "注意: $f が無い"; fi
done

inject_marker '<!-- BUILD_STAMP -->' "$STAMP" < "$SRC_SKILL" \
  | inject_marker '<!-- FRESHNESS -->' "$FRESH_DIST" > "$DIST/skill/SKILL.md"

# --- 2. Claude Code 用（ローカル版：参照を絶対パスで指す）----------------
# 案件フォルダで起動しても解決するよう絶対パスにする。相対だと cwd 依存で切れる。
# 常に本体を読むので鮮度の文言も差し替える。マシン固有なので zip には含めない。
mkdir -p "$DIST/skill-local"
inject_marker '<!-- BUILD_STAMP -->' "$STAMP" < "$SRC_SKILL" \
  | inject_marker '<!-- FRESHNESS -->' "$FRESH_LOCAL" \
  | sed "s|reference/|$(esc_repl "$REPO_ROOT")/|g" > "$DIST/skill-local/SKILL.md"

# --- 3. ChatGPT 用 --------------------------------------------------------
# ナレッジはフラットに置く。ファイル名の衝突が起きないことを先に確認する。
mkdir -p "$DIST/chatgpt/knowledge"

dupes="$(
  { for d in "${DIRS[@]}"; do [ -d "$d" ] && find "$d" -maxdepth 1 -name '*.md' -type f -printf '%f\n'; done
    for f in "${EXTRA[@]}"; do [ -f "$f" ] && basename "$f"; done
  } | sort | uniq -d
)"
[ -z "$dupes" ] || die "フラット化でファイル名が衝突する: $(echo "$dupes" | tr '\n' ' ')"

for d in "${DIRS[@]}"; do
  [ -d "$d" ] || continue
  mapfile -d '' -t files < <(collect_md "$d")
  [ "${#files[@]}" -eq 0 ] || cp "${files[@]}" "$DIST/chatgpt/knowledge/"
done
for f in "${EXTRA[@]}"; do
  if [ -f "$f" ]; then cp "$f" "$DIST/chatgpt/knowledge/"; else echo "注意: $f が無い"; fi
done

{
  echo "# video-knowledge — カスタム指示"
  echo
  echo "${STAMP}"
  echo
  echo "以下をChatGPTのプロジェクト指示（またはGPTのInstructions）に貼る。"
  echo "\`knowledge/\` の中身はナレッジファイルとしてアップロードする。"
  echo
  echo "**ファイル名の読み替え：** 本文中の \`reference/principles/sound.md\` などの"
  echo "パスは、アップロードした \`sound.md\` を指す。ディレクトリは無い。"
  echo
  echo "**注意：** ChatGPT側はナレッジを検索で引くため、「読まない」の制御が効きにくい。"
  echo "発想（工程1）はClaude側で行うこと。"
  echo
  echo "---"
  echo
  strip_frontmatter "$SRC_SKILL" \
    | inject_marker '<!-- BUILD_STAMP -->' "$STAMP" \
    | inject_marker '<!-- FRESHNESS -->' "$FRESH_DIST"
} > "$DIST/chatgpt/INSTRUCTIONS.md"

{
  echo "# video-knowledge（全文結合版）"
  echo
  echo "${STAMP}"
  echo
  strip_frontmatter "$SRC_SKILL" \
    | inject_marker '<!-- BUILD_STAMP -->' "$STAMP" \
    | inject_marker '<!-- FRESHNESS -->' "$FRESH_DIST"
  for f in "$DIST/chatgpt/knowledge"/*.md; do
    echo; echo "---"; echo
    echo "# ファイル：$(basename "$f")"
    echo
    cat "$f"
  done
} > "$DIST/chatgpt/video-knowledge-bundle.md"

# --- 4. 参照切れの検査 ----------------------------------------------------
# SKILL.md が名指ししている .md が reference/ に存在するか。
# 差分を未反映のままビルドすると、存在しないファイルを案内してしまう。
missing=""
while read -r name; do
  [ -n "$name" ] || continue
  [ -n "$(find "$DIST/skill/reference" -name "$name" -type f -print -quit)" ] \
    || missing="$missing $name"
done < <(grep -oE '[a-z0-9-]+\.md' "$SRC_SKILL" | sort -u)

if [ -n "$missing" ]; then
  echo
  echo "警告: SKILL.md が参照しているが reference/ に無いファイル:$missing"
  echo "      差分が未反映か、ファイル名の誤り。SKILL.md 側に但し書きがあるか確認すること。"
fi

# --- 5. zip（配布版のみ。ローカル版は絶対パス入りなので含めない）--------
( cd "$DIST/skill" && zip -qr "../video-knowledge.zip" . )

# --- 結果 -----------------------------------------------------------------
ref_count="$(find "$DIST/skill/reference" -name '*.md' -type f | wc -l | tr -d ' ')"
ref_lines="$(find "$DIST/skill/reference" -name '*.md' -type f -exec cat {} + | wc -l | tr -d ' ')"

echo
echo "ビルド完了（${HASH} / ${DATE}）"
echo
printf '  %-40s %s\n' "$DIST/video-knowledge.zip"               "→ claude.ai の Customize > Skills"
printf '  %-40s %s\n' "$DIST/skill-local/SKILL.md"              "→ .claude/skills/video-knowledge/（このマシン用）"
printf '  %-40s %s\n' "$DIST/chatgpt/INSTRUCTIONS.md"           "→ ChatGPT のプロジェクト指示"
printf '  %-40s %s\n' "$DIST/chatgpt/knowledge/"                "→ ChatGPT へナレッジとしてアップロード"
printf '  %-40s %s\n' "$DIST/chatgpt/video-knowledge-bundle.md" "→ 1ファイルで渡したいとき"
echo
echo "リファレンス: ${ref_count} ファイル / ${ref_lines} 行 / zip $(du -h "$DIST/video-knowledge.zip" | cut -f1)"
