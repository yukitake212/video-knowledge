# 比較候補（未契約・未検証）

**使っていないツール。用途候補があるだけ。** 契約するか継続比較すると決めた時点で、
個別ファイルへ切り出す。

現行の制作プラットフォームは `platforms/magnific.md`。
2系統目は未定（→ magnific.md の「2系統目（未定）」）。

以下すべて 2026-08-28 に公式ページで確認。**製品仕様値であって、測定値でも自社検証でもない。**

## DomoAI — Omni Reference

- Seedance 2.5 を Omni Reference 上で使い、画像・動画・音声の参照を同時に渡す構成
- 案内されている上限：**30画像・10動画・10音声＝最大50**。4〜30秒、480P / 720P
- 公式の用途例に Character PV / VTuber があり、「キャラデザイン＋モーションクリップ＋
  音声参照」の組み合わせを挙げている
- 出所：www.domoai.app/ai-models/seedance-2-5

**用途候補：** 原稿・キャラシート・モーション・声を役割分離して1生成に束ねる。
ただし同じ Seedance 2.5 でも Higgsfield とは案内されている内訳が違う
（→ platforms/higgsfield.md の「ホストによって違う」）。

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
- 2系統目の候補として継続比較すると決めた

**どれも起きないまま古くなったら落とす。** 月次の棚卸しで確認する。
