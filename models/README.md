# models/

**ベースモデルの知識を置く。ホストの知識は `platforms/`。**

## なぜ分けるか

同じモデルでも、どのホスト経由で使うかで参照上限・入力種別・UI・プロンプトの
書き換えが変わる。混ぜると、ホスト固有の制約をモデルの仕様として記録してしまう。

**過去に一度やっている。** 「ショット生成は4秒以上」を Hailuo H3 の制約と気づかないまま
普遍則として記録し、全カットの設計を縛った。

| ディレクトリ | 置くもの |
|---|---|
| `models/` | モデル提供元の公式仕様、公式のプロンプト式、生成モード、ハード上限 |
| `platforms/` | ホストのUI、ホスト側の上限、プロンプトの書き換え、契約・データ面、料金 |

判断に迷ったら、**「ホストを変えても同じか」**で分ける。同じなら `models/`。

## 自社検証はどちらでもない

自分で回して確かめた挙動は `platforms/model-quirks.md` に集める。
**あれは軸が違う。** モデル別でもホスト別でもなく、**出所が自社検証であるという軸のファイル。**

未検証の公式情報と混ぜない。信頼度が違う。

## 構成

`models/video/` と `models/image/` に個別の README は置いていない。**この表がその代わり。**

| 動画モデル | |
|---|---|
| `video/minimax-h3.md` | MiniMax H3 / H3 Max。**現行の主力** |
| `video/seedance.md` | Seedance 2.0 / 2.5。**未検証の推測が中心** |
| `video/wan.md` | Wan 3.0 |

| 画像モデル | |
|---|---|
| `image/nano-banana.md` | Google Nano Banana Pro / Nano Banana 2 |
| `image/gpt-image.md` | OpenAI GPT Image 2 |
| `image/seedream.md` | ByteDance Seedream 5.0 Pro |
| `image/krea-2.md` | Krea 2 |
| `image/soul.md` | Higgsfield Soul ファミリー |
| `image/midjourney.md` | Midjourney |

**Seedream（画像）と Seedance（動画）は別のモデル。** どちらも ByteDance で紛らわしいので、
両方のファイル冒頭に相互参照を入れてある。
