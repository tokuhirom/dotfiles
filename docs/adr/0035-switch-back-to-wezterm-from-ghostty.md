# ADR-0035: Ghostty から WezTerm に戻す

## ステータス
採用

## コンテキスト
ADR-0003 で WezTerm から Ghostty に移行し、その後 Alacritty を経て再び Ghostty を使っていた。

しかし Ghostty は terminfo (`xterm-ghostty`) が同梱されておらず、リモートホストに ssh した際に
terminfo が見つからず表示が崩れる、`TERM` を手動で設定し直す必要があるなど、
運用上の手間が多い。ADR-0003 の廃止理由にあった kitty keyboard protocol 由来の
互換性問題も含め、Ghostty は環境との噛み合わせが悪い場面が多かった。

## 決定
ターミナルエミュレータを WezTerm に戻す。

## 理由
- WezTerm は `xterm-256color` で問題なく動作し、terminfo 周りで困らない
- Linux 側では既に WezTerm を使っており、設定 (`config/.config/wezterm/wezterm.lua`) を共有できる
- ADR-0003 で Ghostty に移行した動機は「試してみたい」であり、WezTerm 自体への不満ではなかった

## 結果
- `config/.hammerspoon/init.lua` の `T` キーの起動アプリを WezTerm に変更
- `Brewfile` で `cask "wezterm"` を有効化し、`cask "ghostty"` を削除
- `mise.toml` の `[dotfiles]` から `~/.config/ghostty` を外し、
  `~/.config/wezterm/wezterm.lua` を共通 (macOS/Linux 両方) に移動
  （`mise.linux.toml` からは削除）
- Ghostty の設定ファイル `config/.config/ghostty/config` は将来また使う可能性があるため残す
- 適用には `bin/brew-sync` と `mise dotfiles apply -E macos` が必要
