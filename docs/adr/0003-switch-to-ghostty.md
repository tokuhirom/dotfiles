# ADR-0003: WezTerm から Ghostty への移行

## ステータス
採用

## コンテキスト
これまで WezTerm を使用していたが、aerospace との相性問題があった。Hammerspoon への移行（ADR-0001）により、タイリング WM の制約がなくなったため、ターミナルエミュレータの選択肢が広がった。

## 決定
Ghostty に移行する。

## 理由
- Hammerspoon 移行により aerospace との相性問題が解消
- WezTerm に特別な不満はないが、Ghostty を試してみたい
- Ghostty は軽量で高速

## 結果
- `darwin/homebrew.nix` で ghostty を有効化
- `config/.hammerspoon/init.lua` で T キーの起動アプリを Ghostty に変更
- WezTerm は一旦残す（フォールバック用）

## 設定 (`config/.config/ghostty/config`)

| 設定 | 値 | 説明 |
|------|-----|------|
| shell-integration | zsh | シェル統合 |
| theme | Aurora | カラーテーマ |
| font-family | JetBrainsMonoNL Nerd Font Mono | フォント |
| macos-option-as-alt | true | Option を Alt として扱う |
| window-padding-x/y | 4 | ウィンドウ余白 |
| confirm-close-surface | false | 閉じる確認を無効化 |
| copy-on-select | clipboard | 選択時に自動コピー |
| scrollback-limit | 10000 | スクロールバック行数 |
| keybind | ctrl+cmd+\` | クイックターミナル |
