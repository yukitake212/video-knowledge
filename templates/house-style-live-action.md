# ハウススタイルブロック｜実写ドラマ調（ティザー用）

**実写調のティザー案件で**そのまま貼る固定文。生成ごとに変えるのは ASSETS と SHOT だけ。

**これは「貼るもの」の原型。** 一度決めたら一字一句そのまま使い回す。
同じ性質のブロックは `templates/lock-blocks.md`（声のロック／参照のコネクタ／
空白の禁止列挙／禁止／命名）。

**実写調のカットにだけ貼る。** 本文は `photorealism` `NOT a cartoon` を含むので、
**完成した静止画（漫画原稿・挿絵）を素材にするカットに貼ると、素材の画風と正面衝突する。**
素材があるカットでは、look の正本は素材のほうで、ハウススタイルブロックは貼らない
（→ principles/still-to-motion.md）。
撮影監督名・配色比率・Restraint節が案件ごとの差し替えポイント。

```
Style: 8K, photorealism. Real organic 35mm film grain, subtle halation, high dynamic
range. NOT a 3D render, NOT a game engine, NOT game-cutscene aesthetic, NOT a cartoon,
NOT AI-glossy.

OPERATING STYLE — ROGER DEAKINS: restrained precision, a single motivated source,
faces held in half shadow, unshowy locked or slow deliberate camera, cold clean realism,
no flourish.

Light: only motivated practical light — overcast daylight through windows, fluorescent
ceiling panels, one soft key. Faithful desaturated skin tones, gentle roll-off, deep but
readable shadows. No fabricated glow, no visible film fixtures, no rim-light halo.

Colour — ACCENT DOCTRINE: ~70% desaturated grey-blue base (concrete, steel desks,
overcast daylight, dark suits) + ~20% warm practical accent (tungsten interior fill,
paper, wood) + ~10% cold cyan counter-note from windows and screens. Saturation stays
low throughout. No teal-and-orange grade.

Texture: matte non-reflective surfaces, lived-in worn materials (aged concrete, stacked
paper, worn steel, dust in the air), organic film grain, no digital gloss, no plastic sheen.

Camera/Optics: 35mm spherical prime, natural motion blur at a 180-degree shutter,
moderate shallow depth of field with gentle focus falloff, natural halation on window
highlights, subtle lens breathing. No artificial flares, no anamorphic streaks, no
impossible drone-like moves.

Skin: pore-level realism — visible pores, fine vellus hair, natural asymmetry, faint
under-eye shadow, no smoothing, no retouching, no beauty filter. Half the face often
falls into shadow.

Acting: every person reads as alive — natural blinking throughout, active brow and
forehead micro-expression, small weight shifts, visible breathing. Restraint is played
inwardly, never as a frozen mask. No dead eyes, no mannequin stillness.

Composition: composed, quiet framing; off-centre and non-symmetrical, except where a
formal symmetry is the subject (memorial, ceremony, formation). Negative space is
allowed to carry the shot.

Restraint: this is a teaser. No impact, no wounds, no blood, no bodies. Violence is
implied by its aftermath and by sound — a muzzle, a cut to black, an emptied street, a
covered floor. Weapons may be present but are never fired into a person on camera.

Technical: smooth stable motion, no flicker, no warping, no morphing; real-time 24fps,
no slow-motion unless a shot specifies it.

Audio: diegetic room tone and environmental SFX only. No music — music is added in the
edit. No subtitles, no on-screen text, no watermarks. No generated dialogue unless a
shot explicitly scripts a line.
```

## 運用メモ

- 全体スタイルは冒頭に1回だけ書き、以降の全ショットに効かせる。ショットごとに書き直さない
- 案件のハウスプリセットとして**一字一句そのまま使い回す**。同一作者の別生成で完全一致を確認した
- この骨格は個人の癖ではなく**界隈の共通様式**。別作者の別案件でも見出しの並びが一致している（Style / OPERATING STYLE / Light / Colour / Texture / Camera-Optics / Acting / Composition / Technical / Audio）。移植できる資産は中身ではなく骨格のほう
- 撮影監督ハンドルの選択肢：
  - **Roger Deakins** — 抑制と精度、単一光源、半分影の顔
  - **Hoyte van Hoytema** — 大判の realism とハンドヘルドの近さ、靄と体積光。壮大・叙事的
  - **近藤龍人** — 日本の室内と自然光のリアリズム。家庭劇・現代劇
  - 1本に1人だけ使う
- **Restraint節はティザー案件の生命線。** 流血・着弾・遺体を全部ここで一度に禁じておけば、各ショットで毎回書かなくて済む。単なる禁止ではなく「暴力はその後と音で示す」と代替を肯定形で書くこと
- Audio節で「音楽は編集で足す」と宣言しておく。生成に音楽を作らせない
