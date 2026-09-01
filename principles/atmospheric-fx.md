# 大気・光・粒子・影の設計

出所と時期を各項目に書くこと。以下は2026-08に収集。**大半が外部情報で自社未検証。**

## 大気は雰囲気ではなく機能

観察したアクションショットでは、霞・粉塵・風がショットの骨格になっていた
（2026-08 corpus/creature-charge）。大気が担っていた機能は5つ。

1. **距離感を作る** — 遠くほど霞むことで奥行きが読める
2. **光を見せる** — 空気がなければ光線は見えない
3. **速度を感じさせる** — 粉塵が流れることで動きの速さが出る
4. **被写体の進路を可視化する** — 巻き上がる粉塵が、どこを通ったかを描く
5. **多少の破綻をなじませる** — 形の粗が霞に紛れる

つまり大気は look ではなく **space glue（空間を接着するもの）／force evidence（力の証拠）／
air visibility（空気を見せるもの）** として設計できる。

**5番目は実務上とくに大きい。** 複雑な形状を至近距離で描かせるのが難しいとき、
霞を厚くすることで破綻の露出を減らせる。

## 密度だけでなくベクトルを持たせる

粒子が漂っているだけでは画が死ぬ。**風を入れると大気に方向が生まれる**
（2026-08 corpus/creature-charge）。

観察した書き方は、突風が吹いている／粉塵が地面を這うように筋を引いて流される／
巻き上がった粉塵が膨らんで風に流れていく、というもの。

大気には **density（密度）だけでなく vector（方向）** が要る。

## 光の役割は被写体を照らすことではない

観察した例の照明は、寒色の曇天のもや光／街路の開けた側から斜めに差す／
厚い霞と舞う粉塵を切り裂いて通る／強い大気遠近／深い影を残す／
前から均一に当てて平坦にしない、という書き方だった（2026-08 corpus/creature-charge）。

光は敵を明るくするためではなく、**霧・粉塵・煙を切り裂いて見せるため**にある。
lighting design は subject visibility ではなく **air visibility** の設計。

## アクセント光は最低限に留める

発光する要素（生体発光、ネオン、モニタ）は、世界全体を照らすほど強くせず、
**局所的なアクセント**に留める。観察した例は「かすかな寒色の紫の光」だった
（2026-08 corpus/creature-charge）。

多要素のシーンで色が散らないための手。色の比率指定と同じ考え方
（→ principles/shot-structure.md）。

## 粒子は奥行き面に分けて配置させる

「正しい奥行き面に散る」という指定がある（2026-08 corpus/creature-charge）。
粉塵を単なるエフェクトではなく、**空間を感じさせる奥行きの証拠**として扱っている。

これを書かないと、粉塵が前景にベタ貼りされたように見える可能性がある（未検証）。

---

## 光源を動機づける

「シネマティック」「moody」とだけ書くより、**実在する光源とその方向を指定する**
（2026-08 / higgsfield.ai/blog/ai-video-look-real-2026）。

分解例として挙がっていたのは、窓を唯一の光源とする／カメラ左／斜め後ろからの逆光／
テーブルからの柔らかい跳ね返り／光の筋の中の埃／暖かい霞／ハレーション。

要点：

- 光源を何かに動機づける（motivated source）
- 光の方向を指定する
- 逆光と跳ね返りを分けて書く
- **粒子を光で可視化する**
- 霞とハレーションを同時に扱う

## 撮影の専門語彙がハンドルになる

Higgsfieldは camera / optics / lighting / motion の専門語彙を大量に使う方向を推している。
**「映画っぽく」と言うより、撮影技術の語彙を使うほうが、モデルが学習した映画的な
潜在空間を引き出せる**という見方（2026-08 / higgsfield.ai/blog/cinema-studio-3.0、
higgsfield.ai/blog/how-we-built-cinema-studio）。

既存の「形容詞を積まない。動きとレンズで書く」と同じ方向
（→ principles/shot-structure.md）。

## 光のパラメータ空間

HiggsfieldのVideo Relightは光を direction / color / brightness / diffuse / angle に分けて
扱っている（2026-08 / higgsfield.ai/blog/video-relight-color-palette-higgsfield）。

プリセット名：Practicals（劇中の実光源）／Window（窓光）／Overhead Fall（頭上から落ちる）／
Contre-jour（逆光）／Soft Cross（柔らかいクロスライト）／Silhouette（シルエット）。

**プリセット名の集合から、光を指示するときのパラメータ空間を逆算できる。**

---

## CG/VFXの物理モデルから語彙を取る

AIプロンプトの語彙を増やすには、**CG/VFXが実際に煙と光をどうモデル化しているか**を
見るのが早い。目的はレンダラーを実装することではなく、
**映像の大気現象を構成している変数に何があるかを知ること。**

### Unreal Engine — Volumetric Fog

霧を density（密度）／scattering intensity（散乱強度）／local・global volume（局所と全体の
体積）／light contribution（光の寄与）／volumetric shadow（体積の影）に分解している。
局所的な霧の粒を置いて密度を変える考え方もある
（2026-08 / dev.epicgames.com/documentation/en-us/unreal-engine/volumetric-fog-in-unreal-engine）。

プロンプトへ移すと、`heavy fog` ではなく
**「低い位置に薄い霞、局所的に濃い粉塵の塊、それが前方から強く照らされている」**
のように書ける。

### Unreal Engine — Light Shafts

いわゆるゴッドレイは、光線そのものが見えているのではない。
**空気中の散乱光が建物などに遮蔽され、その濃淡が筋として見えている**
（2026-08 / dev.epicgames.com/documentation/en-us/unreal-engine/using-light-shafts-in-unreal-engine）。

したがって `god rays` と書くより、
**「指向性の陽光が霞の中で散乱し、窓枠によって筋に分断され、筋と筋の間に影の体積がある」**
のように、散乱・遮蔽・影の空間まで書くほうが物理的に具体的。

### Blender — Volume Scatter

density（密度）／scattering（散乱）／absorption（吸収）／**anisotropy（異方性）** が重要。
Volume Scatter は霧に、Volume Absorption と組み合わせると煙になる
（2026-08 / docs.blender.org/manual/en/latest/render/shader_nodes/shader/volume_scatter.html）。

**とくに anisotropy。** 光が粒子に当たったとき、前方向へ強く散るのか後方へ散るのかで、
逆光の霧の見え方が大きく変わる。

### PBRT — Volume Scattering

transmittance（透過）／extinction（減衰）／phase function（位相関数）／
participating media（関与媒質）を体系的に扱う
（2026-08 / pbr-book.org/4ed/Volume_Scattering、
pbr-book.org/3ed-2018/Volume_Scattering/Phase_Functions）。

phase function を理解すると、**なぜ逆光＋煙で光が強烈に見えるのか**が分かる。
Henyey–Greenstein の位相関数では、前方散乱と後方散乱の違いが扱われている。

### Production Volume Rendering

Pixar、Sony Pictures Imageworks、Disney などの研究者によるSIGGRAPH系資料。
映画制作における smoke / clouds / fire / heterogeneous density（不均一な密度）／
albedo / extinction / phase function / multiple scattering（多重散乱）を扱う
（2026-08 / graphics.pixar.com/library/ProductionVolumeRendering/paper.pdf）。

---

## 数値の単位を決めておく

**大気は % と m で書く。**「薄い霧」ではなく `fog density 40%`、`haze visible at 15 meters depth`。

**ショットをまたいで段階的に上げる。** ショット1で20% → 2で40% → 3で60%。
**同じ濃度を繰り返すと、進行が止まって見える。**

**ホワイトバランスはケルビンで、シーン内で固定する**（3200 / 4000 / 5600 / 8500K）。
場面の気分に合わせて決め、**シーンの途中で変えない。**

（2026-09-02 / 公開Skill `higgsfield-seedance-prompt`（Seedance 2.0 向け・著者名なし・出所表記なし）から。`corpus/research/higgsfield-seedance-skill-2026-09/`。**自社未検証**）

## 変数の一覧

**全部を書くのではない。** どの変数が実際に効くかを検証して削っていく。
以下は「何を観察し、何を書けるか」の候補（2026-08 整理）。

### 煙・霧・粉塵

**密度と分布**
- 全体の密度／局所的に濃い塊／不均一な密度
- 垂直方向の分布／水平方向の分布
- 前景・中景・背景の奥行き分布
- 粒子の大きさの感じ
- 不透明度／透過／減衰／吸収

**散乱**
- 散乱／異方性／前方散乱／後方散乱／位相関数
- 光源との相互作用
- 遮蔽と体積の影

**運動**
- 風のベクトル／乱流／漂う速度
- 散逸／沈降
- 接触による巻き上がり
- 動く物体の後ろに引く後流
- 地面を這う筋
- 空中に留まる微粒子

**形状の呼び方**
- 煙の膜／雲／噴煙／薄いヴェール／局所的な塊

### 光

- 光源の種類／位置／劇中の動機
- 方向／角度／高さ
- 明るさ／色温度
- 柔らかさ・硬さ／拡散の寄与／跳ね返り
- リム／逆光／クロスライト／頭上から落ちる光
- 体積への寄与／シルエットへの寄与
- 影の深さ／接地影
- 空気の可視性／光線の遮蔽／geometryで分断された光の筋

### 時間方向の振る舞い

大気は一枚絵ではなく動画なので、時間の振る舞いを持つ。

- 静止した霞／ゆっくりした漂い／突風／脈打つ煙／転がる霧／乱流
- 動く物体の通過後の後流
- 衝撃の直後の膨らみ
- 徐々に散っていく

観察した例の「巻き上がった粉塵が膨らんで風に流れていく」は、一つの粒子現象の中に
**接地による発生 → 一時的な膨張 → 風による移流 → 後流**の4段階を含んでいた
（2026-08 corpus/creature-charge）。

## 文字カードと接続する

文字カードの背景・処理にも同じ変数が使える。文字の手前と奥の煙、異なる奥行き面を横切る
粒子、文字の輪郭を舐める光線、ハレーション（→ principles/typography.md）。

## 検証したいこと

- 風の指定を外すと、大気が静止して鈍く見えるか
- 粒子の深度指定を外すと、粉塵が前景にベタ貼りっぽくなるか
- 上の変数のうち、実際に効くのはどれか。**効かないものは削る**

（→ models/video/seedance.md の検証計画）
