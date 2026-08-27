# 分業先のツール候補（未契約・未検証）

**特定の工程だけを外に出す先の候補。** 制作基盤の候補ではない。

制作基盤の候補は別。現行が `platforms/magnific.md`、比較対象が
`platforms/higgsfield.md` と `platforms/krea.md`。
2系統目の決め方は OPERATIONS.md の「制作プラットフォームの選択」。

**ここにあるのは、漫画原稿の調査中にWeb検索から出てきたもの。**
こちらの工程が困って探しに行った結果ではないので、
**検索で上位に出るから目に入った、という可能性を割り引いて読む。**

契約するか、案件で1回でも使った時点で個別ファイルへ切り出す。

以下すべて 2026-08-28 に公式ページで確認。**製品仕様値であって、測定値でも自社検証でもない。**

## Runway — Characters / Act-Two

- **Character Script to Video** — キャラクター画像＋打ち込んだ台本、または音声と声から、
  同期した発話映像を生成する。公式ドキュメントは**写実的なキャラだけでなく、
  アニメ調・非人間のキャラも単一画像から扱う**と記載
  - 出所：help.runwayml.com/hc/en-us/articles/51285026291219-Character-Script-to-Video、
    docs.dev.runwayml.com/characters/
- **Performance Capture（Act-Two）** — 演技した動画とキャラクター画像／動画を分けて渡し、
  顔・頭・ジェスチャーを含む芝居を移す。キャラクター画像を使う場合はジェスチャー制御に対応。
  最大30秒・24fps
  - 出所：help.runwayml.com/hc/en-us/articles/42311337895827-Performance-Capture-with-Act-Two

**用途候補：** 短い発話カットの分業先。`platforms/higgsfield.md` の
「リップシンクは専用ツールに投げるのが正しい分担」と同じ方向で、Runway は
アニメ調キャラも公式に対象としている点が追加情報。

**不明：** 日本の漫画原稿のような線画・スクリーントーン主体の入力で、
どの程度原画を保持するか。口周りの線画の崩れ、画風のドリフトは公開情報から分からない。

## Adobe Firefly Video

- Image to Video で pan / zoom / tilt などのカメラ制御を案内
- **参照動画からカメラの動きを抽出して生成へ適用する機能**がある。
  参照動画は5〜10秒・200MB未満（入力条件であって測定値ではない）
- 出所：www.adobe.com/jp/products/firefly/features/image-to-video.html、
  helpx.adobe.com/firefly/web/work-with-audio-and-video/work-with-video/match-camera-motion-to-reference-video.html

**用途候補：** 線画を大きく変形させず、絵の上をカメラが移動するだけの演出。
静止画素材を低変形で動かす場面。

**不明：** 漫画ページ上をカメラが移動する用途を Adobe が公式事例として検証したものは
確認できていない。

## 切り出しの条件

以下のどれかが起きたら、そのツールを個別ファイルへ移す。

- 契約した
- 案件で1回でも使った

**「継続比較すると決めた」は基盤候補の条件なので、ここからは外した。**
基盤の候補は最初から個別ファイルに立てる（→ platforms/krea.md がその例）。

**どれも起きないまま古くなったら落とす。** 月次の棚卸しで確認する。
