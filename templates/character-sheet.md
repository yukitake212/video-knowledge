# キャラクターシートの型

Higgsfieldの公開プロンプトを分解して得た型（2026-08 / corpus/character-sheet-zjasmin）。
**単なる画像生成なのでMagnificでも作れる。** 連載・シリーズ案件では、単体ポートレートではなくこのシートを参照素材にする。

## 一発で作らない

シートは1回の生成で出すものではなく、層を分けて順に確定させる。
Higgsfieldの実制作例でも、基本シートを作る → 顔を1つに絞る → 気に入った衣装要素を
組み合わせて最終ルックのシートを再構成する → 別衣装へ編集する → 状態違いを別シート化する、
という流れが取られている（2026-08 / Higgsfield公式の制作例。自社未検証）。

別の公式広告制作例では、最初のシートを保持したまま**レイアウト・顔・比率・照明を固定し、
衣装だけを別の服へ置換する**編集が行われている。

### 5層

**Identity → Body → Wardrobe → State → Packaging** の順に確定させる。

| 層 | 確定させるもの |
|---|---|
| Identity | 顔。正面寄り・大きく・ニュートラルな表情。髪、眼、肌、特徴物まで |
| Body | 身長、肩幅、胴長、脚長、体格。**顔と独立して決める** |
| Wardrobe | 衣装。前面、背面、素材、丈、靴。必要なら衣装だけ先に生成する |
| State | 同一人物の状態違い。通常／濡れ／汚れ／負傷／冬服／汗をかいた状態 |
| Packaging | 最後に一枚へ統合する |

Identity が最重要で、最初に確定させる。ここが動くと後段が全部やり直しになる。

### State を毎ショット書かない

汗・汚れ・濡れ・負傷は、毎カットのプロンプトで指定し直すのではなく、
**必要に応じて state sheet として固定参照にする**（2026-08 / 未検証の方針）。
案件の中で同じ状態が3カット以上出るなら、シート化したほうが安い。

### wardrobe replacement の責任分配

衣装だけを差し替えるときは、**顔・比率・レイアウト・照明を固定し、衣装だけ変える**。
ここの責任分配を崩すと、服を変えたつもりで人物が変わる。

```
Character reference sheet of the character shown in @Image1,
wearing the outfit/clothing from @Image2, labeled "[名前]" at the top.
[中立な撮影環境＝seamless cyclorama、professional studio lighting、soft natural shadows]
[品質スタック：Photorealistic, hyper-realistic rendering, ultra high quality, 8K,
 extremely detailed, sharp focus]
[肌・生地の質感スタック：highly detailed realistic skin with visible pores,
 fine skin texture, subtle imperfections, natural subsurface scattering,
 detailed fabric texture]
Keep the face, hairstyle, body type and likeness from @Image1 consistent.
Apply the garments, colors and material details from @Image2 to the character.
LEFT HALF — two headless full-body views (ghost mannequin, neck down only,
no head) at equal scale, [ポーズ], aligned to the same horizon line,
consistent proportions, the outfit matching across both views:
front view and back view.
RIGHT HALF — a single large straight-on facial close-up of the same character,
filling the height of the panel, neutral expression, no other faces anywhere
in the sheet.
[締めの枠指定：full figure not cropped]
```

## 理想形のレイアウト

2026-08 に実物のシートを目視確認した（第三者の作例。画像は video-corpus 側）。
横長1枚を左右で分ける構成。

### 左側（およそ53%）

同一衣装の全身を、**前面と背面の2体**並べる。

- **首から下だけ。頭部は無い**（headless / ゴーストマネキン型）
- 2体が同一スケール、同じ地平線、同じ照明
- 前後で衣装が完全に一致している
- 観察した実例では、光沢のある淡い黄土色のクロップド長袖トップ（ハイネック、腹部が出る丈）、
  ベルト付きのベージュのカーゴパンツ（複数のポケット、裾が絞られている）、
  オレンジ〜赤茶のレースアップブーツ
- 背景は影の落ちない無地の白

前後を並べることで、丈・腰位置・パンツのボリューム・靴・背面のポケット配置まで
一度に確定できる。

### 右側（およそ47%）

**顔の大きな正面クローズアップを1枚だけ。**

- 顔が縦幅のほぼ全部を占める
- 髪の毛先・前髪の分かれ方・毛流れまで読める解像度
- 眼の形、虹彩、まつ毛、キャッチライトの位置が読める
- 顔に付く特徴物（実例では鼻梁を横切る銀のホログラム状のテープ）が明確に見える
- 表情はニュートラル寄り
- 背景は無地の明るい面

**顔にピクセル数を最大限割く**のが要点。動画モデルが一番欲しいのは identity 情報で、
そこの解像度がそのまま同一性の歩留まりになる。

### 注意点

観察した実例では、顔クローズアップの下端にわずかに暗色の襟元が写っていて、
**全身側の衣装（淡い黄土色のトップ）と一致していない**。

顔アップは首から下がほぼ写らない構図にするか、写る範囲は全身側の衣装と揃える。
揃っていないと、参照したときに襟元だけ別の服が出る余地を残す。

## なぜこの形か

- 冒頭で**成果物の種類を名指し**する。「〜の写真」ではなく「character reference sheet」。何を作るかが決まると構図の解釈幅が一気に狭まる
- 参照の役割分担は**2回書く**。冒頭の一文で宣言し、中盤でもう一度「@Image1から顔・髪型・体型を保て、@Image2から服・色・素材を適用せよ」と明示的に繰り返す
- 画面を LEFT HALF / RIGHT HALF と大文字で分割してから各領域の中身を書く。多面構図はこの分割指定がいちばん効く
- シートを実用品にするのは**整列条件**：同一スケール・同じ地平線・比率一致・両ビューで衣装一致。これが無いと絵として綺麗でも参照に使えない
- **シート内に顔は1つだけにする。** Higgsfieldは、シート内に顔が複数あると動画モデルが
  ドリフトするため、全身側の顔を消して参照する顔を1つにする、という考え方を出している
  （2026-08 / Higgsfield公式。自社未検証）。実物のシートを目視確認したところ、
  全身側は headless で顔は右の1枚だけだった（2026-08 / 第三者の作例）。
  顔同士が競合しないうえ、1枚に割けるピクセル数も増える
- 顔の高解像度アンカーが要る場合（目や口元の細部にモデルを commit させたい場合）は、
  シートに枠を増やすのではなく**別シートとして持つ**。シート内の顔の枚数は1枚を保つ
- **未解決：** ByteDance の実践ガイドは「複数アングルを1枚のグリッドにまとめず別画像で渡す」
  と述べている（2026-08 / 二次紹介）。シートの構成がこれに該当するかは不明。
  被写体が1人の場合の扱いも書かれていない。**次に Seedance でシートを使うとき、
  1枚版と分割版を比較する**
- 背景は意図的に無味（cyclorama）にする。シートに環境情報が入ると、それを参照した先のカットに混入する
- Higgsfieldのモデルシート例でも、**無地背景・余計な物を置かない・照明を揃える**方向が
  使われている（2026-08 / Higgsfield公式。自社未検証）。観察した実例も影の落ちない
  無地の白背景だった
- 肌の質感は「photorealistic」だけでは出ない。毛穴・微細な肌理・わずかな粗・subsurface scattering と、物理的に数えられる語で積む

## モデルに渡すシートと、人が見るカードを分ける

観察した実例のシート左上には、名前・身長・性格・声が文字で入っていた
（2026-08 / 第三者の作例）。おおむね次の形。

```
[キャラクター名]
Height: [身長] cm
[性格を数語で。気質と、それを隠す癖まで]
Voice: [話し方の癖・音域]
```

制作管理には便利だが、**動画モデルへの画像参照としては、文字が視覚identityに不要で、
画面への文字混入の要因にもなり得る**（2026-08 / 推測。検証していない）。

そのため2種類持つ。

### A. model-facing sheet — 生成に渡す。これが基本形

- 顔クローズアップ1枚
- 衣装の前面（headless）
- 衣装の背面（headless）
- 無地背景
- **文字なし**

### B. production card — 人が見る

Aと同じレイアウトに、名前・身長・性格・声・衣装ID・version を足したもの。

身長・性格・声は既に `templates/shot-schema.md` の ASSETS 台帳に持つ項目なので、
production card は台帳の視覚版と考えてよい。**生成に渡すのは常にAのほう。**

## キャスティング（顔をどう決めるか）

- 顔は「引き当てて採否を決める」のではなく、**軸を先に決めて振る**。ジャンル・時代・アーキタイプ・体格・衣装・imperfections を明示的に書いてグリッドを作る（HiggsfieldのSoul Castのパラメータ設計を移植したもの）
- **imperfections を積極的に指定する。** AIの顔がプラスチックに見えるのは欠点が無いから
- 顔の参照素材は単独ポートレートにする。複数人が写っていると手前の顔が優先される

## 服装

公開プロンプトでは、**服を人物から独立したアセットとして扱っている**。
キャラクターシートを作る段階で、人物の参照と服の参照を別々に渡して合成する。
服の参照は白背景に置かれた服だけの画像（ECの商品写真のような形）。

これにより、同じ人物に別の服を着せたシートも、別の人物に同じ服を着せたシートも作れる。

### 書き方

- **一点ずつ数え上げる。** 「ネイビーの半袖ポロ、グレーのマイクロショーツ、オリーブの
  スエードの幅広ベルト、裸足」。「スーツ姿」では書かない。**曖昧に残した部分は生成の
  たびに変わる**
- 靴や小物、裸足かどうかまで書く
- 場面によって外す小物は、その旨も書く（「家では choker なし」）

### 服に物語を運ばせる

- 参照写真の服を継承させたくないときは、否定だけでなく**置き換えを全部肯定形で書く**
  （→ shot-structure.md の参照の扱い）
- 二人が同じ装いをしていることが関係を語る、記章も文字もない全身黒が匿名性を作る、
  といった使い方をしている
- **人物造形が服で作れるなら、それは台詞を1本減らせる。** 周囲が着崩している中で
  一人だけ整っている、といった書き方をすれば、説明なしで人物が立つ
- 服が意味を担う場合は**物アセットカードの対象にもなる**（→ templates/asset-card.md）

## 観察した実例の生成プロンプト（推測・原文は未入手）

**以下は原文ではなく、出力から逆算した推測。** 検証していない。

構造としては次に近いと推測される。

- professional character reference sheet
- fixed horizontal layout
- headless full-body front / back
- large close-up identity portrait
- exact same wardrobe / proportions / light
- clean white / gray seamless

Higgsfield公式にも、後ろ全身＝headless ghost mannequin、前全身＝headless ghost mannequin、
右＝タイトな顔のクローズアップ、という構成が実在する（2026-08 確認）。

この形式は一作者の独自様式というより、**2026年時点で収束しつつある character-reference
architecture** として捉えられる可能性がある。
