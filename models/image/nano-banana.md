# Google Nano Banana Pro / Nano Banana 2

2026-08-28 確認。**出所は Google Cloud 公式ブログ「The ultimate Nano Banana prompting guide」
（2026-03-06）。実物確認済み。** 自社では未検証。

正式名称は **Nano Banana Pro = Gemini 3 Pro Image**、**Nano Banana 2 = Gemini 3.1 Flash Image**。
コードネームのほうが通りがよいが、API では正式名称を使う。

## 仕様

| | Nano Banana Pro | Nano Banana 2 |
|---|---|---|
| 正式名 | Gemini 3 Pro Image | Gemini 3.1 Flash Image |
| 入力トークン | 65,536 | 131,072 |
| 出力トークン | 32,768 | 32,768 |
| 解像度 | 1K / 2K / 4K | 1K / 2K / 4K ＋ 512px |
| 参照画像 | **最大14枚** | 最大14枚 |

アスペクト比は両方が 1:1 / 3:2 / 2:3 / 3:4 / 4:3 / 4:5 / 5:4 / 9:16 / 16:9 / 21:9。
Nano Banana 2 はさらに 1:4 / 4:1 / 1:8 / 8:1。

知識のカットオフは両方 2025年1月。**ただし両方ともウェブ検索によるリアルタイム情報を持つ。**

## クライアント案件で先に確認すること

**生成物には C2PA の Content Credentials と SynthID の電子透かしが必ず入る。**

出版社へ納品する素材にこれが入ることになる。**クライアントに説明が要る可能性がある。**
案件契約に来歴情報や透かしについての条件があるか、先に確認する
（→ OPERATIONS.md「クライアント原稿・第三者著作物の入力」）。

## 基本

- **具体的に書く。** 被写体・照明・構図を具体で
- **肯定形で書く。** 「no cars」ではなく「empty street」
- **カメラを制御する。** 「low angle」「aerial view」のような撮影用語を使う
- **対話的に反復する**

**プロンプトは強い動詞で始める。** どの操作をしたいのかをモデルに最初に伝える。

### 肯定形について注意

Google は肯定形を推奨しているが、**OpenAI は逆に「no watermark, no extra text, no logos」を
明示的に書けと言っている**（→ models/image/gpt-image.md）。

**2社で食い違う。** 既存の `principles/guards.md` は動画側の corpus 由来で
「否定は末尾にまとめる」。**画像では否定の扱いがモデルによって違う可能性がある。**
未検証。

## 5つの式

### 1. 参照なしの生成

```
被写体 ＋ 動作 ＋ 場所・文脈 ＋ 構図 ＋ スタイル
```

キーワードの羅列では足りない。**場面を叙述的に書く。**

### 2. 参照ありの生成

```
参照画像 ＋ 関係の指示 ＋ 新しい状況
```

「添付のスケッチを構造として、添付の生地サンプルを質感として使い、
高精細な3Dのアームチェアのレンダーに変換して、日の差すミニマルな居間に置く」。

**キャラクターの一貫性や、特定の商品を新しい環境へ入れるのに使う。**

### 3. ウェブ検索を使う生成

```
検索の要求 ＋ 分析の指示 ＋ 視覚化の指示
```

架空の場面を描写するのではなく、**実データを取ってこさせて、それをどう見せるかを指定する。**

### 4. 文字

- **引用符で囲む**
- **書体を指定する。** 「太い白のサンセリフ」「Century Gothic 12px」のように
- **翻訳と地域化ができる。** プロンプトを1つの言語で書き、出力の言語を指定する
- **文字を先に作る。** まず会話で文言を確定させてから、その文字を含む画像を頼むほうが
  結果が良い

10言語以上の多言語文字生成に対応。

#### 成立した実例 — 日本語の縦型タイトルカード

日本語の文字を含む9:16のタイトルカードを直接生成できた（2026-08-28 / Nano Banana Pro、1回）。
**書体・字間・色・配置に加えて、空けておく領域**を明示している。

```
Vertical 9:16 title card for a Japanese book teaser, 1080x1920. Warm off-white paper
background with very subtle grain, soft light from the upper left, clean and minimal,
no illustration, no logo.

All text is set in an elegant Japanese serif typeface (明朝体), cinematic and refined,
with generous letter-spacing, crisp and perfectly legible, deep charcoal ink color,
centered.

Near the top, small and light weight:
"（告知の一文）"

Leave the entire middle of the frame completely empty — a clean rectangular area of
plain background with a soft drop shadow suggesting a book cover will be placed there.
No book, no cover art, no object, no placeholder image.

Below that empty area, small:
"（著者・スタッフ表記）"
"（出版社名）"

Keep the bottom 20 percent of the frame completely clear.

Correct Japanese glyphs, correct kerning, no missing strokes, no invented characters,
no English text anywhere.
```

**読みどころ。**

- **最終行は字形を担保する定型として使い回せる。**
  `Correct Japanese glyphs, correct kerning, no missing strokes, no invented characters`
- `Leave the entire middle ... completely empty` の直後に
  `No book, no cover art, no object, no placeholder image`。
  **空けさせるには名指しの禁止が要る**（→「編集」節）
- `Keep the bottom 20 percent of the frame completely clear` — 縦型のUI帯
  （→ `principles/vertical.md`）をプロンプト側で確保している
- 差し替える箇所は `"（…）"` の形で外に出しておくと、案件ごとに埋めるだけで済む

### 5. クリエイティブディレクターとして指示する

**照明を設計する。** 「三点ソフトボックス」「硬く高コントラストのキアロスクーロ」
「ゴールデンアワーの逆光で長い影」。

**カメラ・レンズ・焦点を選ぶ。** 機材名で画の性格が変わる。GoPro なら没入的で歪んだ動きの感じ、
Fujifilm なら本物らしい色再現、使い捨てカメラなら生々しいフラッシュの質感。
レンズは「f/1.8 の浅い被写界深度でローアングル」のように明示する。

**カラグレとフィルムの銘柄を決める。** 「1980年代のカラーフィルム、わずかに粒状」
「くすんだティール寄りのシネマティックなグレーディング」。

**材質と質感を書く。** 「スーツ」ではなく「濃紺のツイード」。「鎧」ではなく
「銀の葉模様が刻まれた華美なエルフのプレートアーマー」。

## 編集

- **意味的なマスク。** テキストでマスクを定義して、一部だけを編集する
- **変えない部分を明示する**（→ principles/image-repair.md）
- **「空けろ」だけでは空かない。置かせたくないものを名指しで禁止する。** タイトルカードの
  一部を空けて後から実物の画像を置く設計では、`no book, no cover art, no object,
  no placeholder image` のように**想定される描き足しを列挙する**
  （2026-08 / **推測。書かなかった場合との比較はしていない**。上の「変えない部分を明示する」
  と同じ方向。→ `principles/typography.md`）
- 参照を足してのスタイル転写・要素追加もできる

## 動画への受け渡し

Google 公式が **「Nano Banana でキーフレームを作り、Veo でその間を生成する」**と
明記している。

**既存の `principles/still-to-motion.md` と一致する。** 静止画を先に確定させて動きを後から
乗せる責任分配を、モデル提供元が公式のワークフローとして出している。

## 未確認

- 自社で生成していない
- Magnific / Higgsfield 経由で使えるか（Higgsfield は Nano Banana を統合していると
  自社発表がある）
- 電子透かしが実際にどう入るか、納品時に問題になるか
- Vertex AI の公式ドキュメント本体は未読。**上記より細かい規則がある可能性が高い**
