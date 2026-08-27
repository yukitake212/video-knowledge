# 物アセットカードの型

人物シート（character-sheet.md）の物版。**意味を担う物、または2回以上出る物**だけ作る。
1回きりの背景小物は、その場のプロンプト内で書けばよい。

## なぜ必要か

ある案件で、原作に出てくる小道具を固有名詞1語で指定した結果、映像化すると
何の変哲もない量産品に見え、非常に地味に写った。原作にはその物について
「粗悪なコピー品」「本来あるべき刻印が削られている」「正規の流通に乗っていない」
「持ち主でない痕跡が一つだけ残る」という記述があり、**そのすべてが画になる材料
だったのに一つも指定していなかった**（自社の失敗）。

公開プロンプトを分解した例では、武器が人物と同格のアセットとして扱われていた。
外見・構造・持ち方・発射の仕方・「拳銃のように持つな」まで書き、キャラクターと
同じ台帳に載せている（2026-08 corpus/mecha-bug）。

## 型

```
[物の名前] object reference sheet, labeled "[名前]" at the top.
Neutral seamless cyclorama background, even professional studio lighting,
soft natural shadows.
Photorealistic, hyper-realistic rendering, ultra high quality, 8K,
extremely detailed, sharp focus.
[質感スタック：素材・仕上げ・摩耗を物理語で]

FOUR VIEWS at equal scale, aligned to the same horizon line,
consistent proportions and identical finish across all views:
1. straight-on side profile, full object, not cropped
2. opposite side profile
3. the surface that is gripped or handled, seen from above
4. an extreme macro close-up of [意味を担う一点]

[締めの枠指定：full object not cropped]
```

## 書き方

- **質感は物理語で積む。** 「粗悪品」では画にならない。安っぽい鋳造の梨地、摩耗した
  青焼き、角の塗装剥がれ、と数えられる条件に翻訳する
- **4面目のマクロが本体。** その物が物語で担っている意味の宿る一点を選ぶ。
  刻印があるべき場所が平らに削られている、握りに残った痕跡、割れたレンズ。
  ここが決まっていない物は、そもそもアセットにする必要がない
- 背景は無味（cyclorama）。環境情報が入ると、参照した先のカットに混入する
- 挙動の制約がある物は、カードではなくプロンプト側の ASSETS 台帳に書く
  （「この銃はフルオート連射のみ・拳銃持ちにするな」など）→ shot-schema.md

## 作る基準

- その物が**2回以上出る**
- または、その物が**意味を担う**（言葉なしで何かを伝える役目がある）

どちらでもない小物は作らない。
