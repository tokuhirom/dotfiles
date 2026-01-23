# ADR-0001: Hammerspoon の導入

## ステータス
採用

## コンテキスト
現在 aerospace をタイリングウィンドウマネージャーとして使用しているが、実際にはタイリング機能は必要としていなかった。必要なのはショートカットキーでウィンドウの位置・サイズを制御する機能のみ。

aerospace は以下の問題もある：
- sketchybar との相性問題（上部に余分なスペースができる）
- 一部のアプリ（wezterm, ghostty, alacritty）との相性問題

## 決定
Hammerspoon を導入する。将来的に aerospace から完全に移行する可能性がある。

## 理由
- タイリング WM は不要、ウィンドウ配置のショートカットだけで十分
- macOS ネイティブの API を直接使うため、相性問題が起きにくい
- Phoenix（JS）と Hammerspoon（Lua）の比較:
  - Lua に慣れていないが、読むことはできる
  - 設定は Claude に書いてもらうので JS でも Lua でも変わらない
  - Hammerspoon の方がコミュニティが大きく情報が多い
  - → Hammerspoon を選択

## 結果
- `darwin/homebrew.nix` に hammerspoon を追加
- `config/.hammerspoon/init.lua` で設定を管理
- 移行完了後、aerospace と sketchybar は削除予定
