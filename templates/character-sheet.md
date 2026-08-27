# キャラクターシートの型

Higgsfieldの公開プロンプトを分解して得た型（2026-08 / corpus/character-sheet-zjasmin）。
**単なる画像生成なのでMagnificでも作れる。** 連載・シリーズ案件では、単体ポートレートではなくこのシートを参照素材にする。

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
LEFT HALF — two full-body views at equal scale, [ポーズ], aligned to the same
horizon line, consistent proportions, the outfit matching across both views:
front view and back view.
RIGHT HALF — three studies of the same character: straight-on portrait,
profile head shot, and an extreme close-up of the eyes.
[締めの枠指定：full figure not cropped]
```

## なぜこの形か

- 冒頭で**成果物の種類を名指し**する。「〜の写真」ではなく「character reference sheet」。何を作るかが決まると構図の解釈幅が一気に狭まる
- 参照の役割分担は**2回書く**。冒頭の一文で宣言し、中盤でもう一度「@Image1から顔・髪型・体型を保て、@Image2から服・色・素材を適用せよ」と明示的に繰り返す
- 画面を LEFT HALF / RIGHT HALF と大文字で分割してから各領域の中身を書く。多面構図はこの分割指定がいちばん効く
- シートを実用品にするのは**整列条件**：同一スケール・同じ地平線・比率一致・両ビューで衣装一致。これが無いと絵として綺麗でも参照に使えない
- **目のエクストリームクローズアップを1枠入れる。** 顔の細部にモデルを commit させる高解像度アンカーになり、以降のi2vが掴みやすくなる
- 背景は意図的に無味（cyclorama）にする。シートに環境情報が入ると、それを参照した先のカットに混入する
- 肌の質感は「photorealistic」だけでは出ない。毛穴・微細な肌理・わずかな粗・subsurface scattering と、物理的に数えられる語で積む

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
