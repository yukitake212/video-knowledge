# 芝居の演出指定

2026-08 にHiggsfieldの公開プロンプト（Seedance 2 / 2.5）を分解して抽出。出所は各項目の末尾。

## 目線

- 目線は方向ではなく**対象**で書く。画面外のものでもよく、それが視線の向きを固定する（「女の子たちのほうを見て（画面外）」「自分の正面をまっすぐ見る」）（corpus/sofa-scene, sofa-scene-2）
- 目線は**時間パターン**でも書ける。「前方の道路と後ろの負傷者のあいだで視線を往復させる」のように、往復そのものが葛藤を表す（corpus/backseat-bleeding）
- 目線は**注意の状態**として書くのが最も自然。「女の子たちのほうは見ず、ストレッチに没入している」。眼球の位置ではなく、何に気を取られているかを書く（corpus/sofa-scene-2）

## 話し方

- 声は2層で管理する。ASSETS台帳に恒久的な声質（音域・話し方の癖）、各ショットにその場の言い方（「好奇心まじりに、急かすように」「したり顔で誇らしげに」）（corpus/sofa-scene）
- セリフは ACTION TIMING の時間帯に置き、直後に気分を短く添える（「乗り気で、少し急いている」程度の一言）。Audio節では声の聞こえ方を別に書く（「低く途切れがちな涙声の慰め」）（corpus/sofa-scene, backseat-bleeding）
- 台帳に身長をcmで書く。同一フレーム内の人物の相対スケールが固定される（corpus/sofa-scene）

## 表情

- 表情は**類義語3つで三角測量**する（shy, childish, funny little smile — sweet and bashful, a small guilty-cute grin）。1語だと解釈幅が広すぎ、多すぎると散る（corpus/sofa-scene-2）
- 表情は**内的な原因**で定義すると外さない（「何も聞こえなかったかのような、少し戸惑った表情」）（corpus/sofa-scene-2）
- 感情はラベルではなく**身体症状と、こらえている努力**で書く（涙が今にも溢れる／顔がくしゃりと歪む／顎が震える／かろうじて保っている）（corpus/backseat-bleeding）

## 動きと「生きている下限」

- **顔を死なせないための能動指定**：瞬きを常時入れる、額と眉の微細表情を動かす、mask-face と dead eyes を禁じる。静止させるために瞬きや表情を止めると、AIっぽい死んだ顔になる（corpus/sofa-scene ほか全プロンプト共通）
- 何もしていないカットにも「生きている下限」を書く。呼吸・瞬き・小さな自然な動き（corpus/sofa-scene-2）
- 動きは**環境に起こさせる**。段差の衝撃、ハンドル修正、風。人物が自発的に動かなくても画が生きる（corpus/backseat-bleeding）
- 人物Aが人物Bを動かす形で書ける（「近づいて、そっと前に倒してストレッチさせる」）。芝居の連鎖になる（corpus/sofa-scene）
- 間違ったポーズを先回りして名指しで打ち消す（「頭は下げるのではなく、横に傾ける」）。動きの幅も限定する（「ふつうのストレッチ。アクロバットはしない」）（corpus/sofa-scene-2）
- モデルが取りがちな**隣接解釈**を名指しで潰す：「SLOW PUSH-IN (dolly), not slow-mo」「calm, low-key — NOT a dramatic reveal」（corpus/sofa-scene-2）

## 構図とブロッキング

- 構図は毎ショット「off-centre, never centred」と書く。これだけでドキュメンタリー的な生っぽさが出る（corpus/sofa-scene, sofa-scene-2）
- BLOCKING を独立ラベルで書き、幾何と、**その幾何が動作を強制する理由**まで書く（「真後ろに座っている。斜めではない。だから運転手は自分の肩越しに手を回すしかない」）（corpus/backseat-bleeding）
- ショットごとに「ONLY @ImageA in frame」と登場人物を制限する。人数は数で固定する（「車内にいるのは正確に2人」と数で明示する）（corpus/sofa-scene-2, backseat-bleeding）
- **生成が苦手なものは構図で画面外に出す。** 人はそこにいる設定のまま、オーバーザショルダーと背景の完全ボケで写さない。同時に「空のソファを見せるな」と失敗の形を名指しする（corpus/sofa-scene-2）
- 背景を読めなくするのはコスト削減の技でもある。ボケて判別不能なら破綻しようがない。LOCATION MAPとOPTICSの2箇所で「unreadable, no sharp furniture, creamy bokeh」と念を押す（corpus/sofa-scene-2）
