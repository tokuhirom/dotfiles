# ADR-0002: sketchybar のカレンダー表示を Itsycal に置き換え

## ステータス
採用

## コンテキスト
aerospace から hammerspoon への移行に伴い、sketchybar の必要性を見直している。
sketchybar で便利だったのはカレンダー表示機能。現在 meetingbar も使っているが、特定のカレンダーだけ表示させることができない問題がある。

## 決定
Itsycal を導入してカレンダー表示を担当させる。

## 理由
- 無料で軽量
- 特定のカレンダーを選択して表示可能（meetingbar にはない機能）
- メニューバーに常駐してカレンダーを表示
- sketchybar 全体を維持するより、専用アプリの方がシンプル

### 検討した代替案
- **MeetingBar**: 特定カレンダーのフィルタリング不可
- **Dato**: 有料
- **Fantastical**: 有料、オーバースペック
- **sketchybar 維持**: aerospace 廃止後は冗長

## 結果
- `darwin/homebrew.nix` に itsycal を追加
- sketchybar は aerospace と一緒に後日削除予定
