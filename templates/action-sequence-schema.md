# アクションシーケンスの型

Seedance 2.0 / 2.5 向けの公開プロンプトを分解して得た型
（2026-08 / corpus/zephyr-cliffhang, corpus/creature-charge）。**自社未検証。**

`templates/shot-schema.md` が会話・芝居のマルチショットの型なのに対して、
こちらは**身体的な負荷のあるアクションをビート列で撮る**ときの型。

## 9つのブロック

順序に意味がある。上ほど大域的で、下へ行くほど局所的になり、最後にもう一度大域へ戻る。

| # | ブロック | 何を書くか |
|---|---|---|
| 1 | PREMISE | 何のシーンか。1〜2文 |
| 2 | Reference binding | 各参照の役割と読み込み順 |
| 3 | Locked invariants | 絶対に崩さない事実。位相・同一性・場所・禁止 |
| 4 | Physical effort state | どれだけ苦しいか。行為とは別に書く |
| 5 | Style / physics preset | 見た目と、世界の振る舞いの法則 |
| 6 | Asset dictionary | 参照の辞書 |
| 7 | Beat list | 時間展開。各ビートに終端状態まで |
| 8 | Shared across all beats | 全ビート共通の再固定 |
| 9 | Negative taxonomy / Positive locks | 末尾の再固定 |

## 型

```
PREMISE
[何が起きているか。開始状態と終了状態を1〜2文で。前後のプロンプトとの接続も]

REFERENCE BINDING（この順で読み込む）
@Image1 = @[名前] — [役割：look anchor / first frame anchor / 物体の同一性 /
          人物の同一性 / 場所の連続性]。[この参照が支配するもの]only。
@Image2 = ...
[※ 順序が効くかは未検証。→ models/video/seedance.md]

LOCKED INVARIANTS
GEOMETRY (locked)     [位相関係。上／下／逆さ／どこから伸びて／どこを掴むか]
[行為] — [難易度] (locked)  [どれだけ苦しいか。→ PHYSICAL EFFORT へ]
[人物名] (locked)     [身長cm・消えない識別特徴・衣装を一点ずつ]
TWO DISTINCT [対象] (locked — do NOT mix)
                      [同種2体を、色／形／位置／物語上の役割の4軸で書き分ける]
ONE [場所] (locked)   [ひとつの場所。新しい場所を発生させない]
NO UI / NO TEXT (locked)

PHYSICAL EFFORT STATE
行為：[動詞]
難易度：[かろうじて／余裕で／限界まで]
身体症状：[震え／滑り／踏ん張り／息]
感情のトーン：[疲弊／恐怖／集中]
見せる部位と、その部位が示す力学：
  [手＝掴む／背中＝踏ん張り／腰＝引き上げ／足＝接地／膝＝進んだこと]
柵：[完全着衣／品よく／努力の強調。→ principles/guards.md]

STYLE / PHYSICS PRESET
Style        [画質・フィルム・NOT 3D / NOT ゲームエンジン / NOT アニメ]
Operating    [撮影監督ハンドル1語]
Lighting     [光源・方向・質]
Color        [ベース約70% / アクセント約20% / カウンター約10%]
Texture      [力の証拠になる質感を列挙。→ principles/shot-structure.md]
Camera/Lens  [レンズ数値・シャッター・手持ちの質]
Physics      [重量・慣性・接地・落下・張力。nothing floats で締める]
Continuity   [場所・光・天候・色温度の一貫]
Technical    [fps・スローモーションの可否・flicker/warp/morph の禁止]
Audio        [全体の音の契約。→ principles/sound.md]
Integration  [その場で撮られている／貼られていない／グレイン一致／
              ライティング一致。→ principles/guards.md]

ASSETS
@[名前] = [外見を一点ずつ。参照が支配するのは何か]

BEAT LIST（~Ns、全Nビート）
BEAT 1 — [ショットサイズ／アングル]（0.0–X.Xs）
  [そのビートで何が起きるか]
  終端状態：[どういう状態でこのビートを終えるか]
  音：[このビート固有の音]
BEAT 2 — [進行を証明できるアングルに変える。バリエーションではない]
  ...

SHARED (all beats)
[全ビートで守る大域制約を、ここでもう一度まとめて書く。
 ビート別の記述で上書きされた制約を最後に戻す]

NEGATIVE TAXONOMY ／ POSITIVE LOCKS
[どちらか一方。→ principles/guards.md の使い分け]
```

## 使うときの規律

- **ビートのアングルは進行の証明として選ぶ。** 同じ「登っている」でも、上から撮るのと
  下から撮るのでは、どこまで進んだかの読めかたが違う
  （→ principles/shot-structure.md）
- **各ビートの終端状態を必ず埋める。** 空欄にすると runaway motion が出やすい
- **ビートの開始は準備からではなく、運動の途中から入る**
- 短尺（4〜6秒）なら **setup → collision → exit** の3相で足りる。
  長尺（15秒前後）で5ビート程度
- **長すぎるアクションは中間安定姿勢で切って2本に分ける。** 分割点の条件は、
  開始姿勢が明確／次へ接続しやすい／一枚絵として安定／失敗しても再生成しやすい、の4つ
- 4番（Physical effort state）を飛ばすと、アクションが単なる移動に見える

## 分割の記法

2本に分けるときは、両方の PREMISE に接続を書く。

```
PROMPT 1 of 2 — [開始] → [中間安定姿勢]
PROMPT 2 of 2 — [中間安定姿勢から] → [終了]
```

中間安定姿勢は両方のプロンプトに同じ文言で書く。片方だけ書くとつながらない。

## この型を使わない場合

会話・芝居中心のカット、静止に近いカット、文字カードには使わない。
それぞれ `templates/shot-schema.md` を使う。
