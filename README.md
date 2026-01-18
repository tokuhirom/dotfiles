# tokuhirom の dotfiles

これは私の dotfiles リポジトリです。

## 🚀 クイックスタート（Nix - 推奨）

**新機能: 宣言的な設定管理のため Nix への移行中！**

```bash
cd ~/dotfiles
./install-nix.sh
```

完全なドキュメントは [NIX_README.md](NIX_README.md) を参照してください。

**従来のセットアップ（引き続き動作します）:**
```bash
./setup.sh
./link.sh
```

## 私の環境

- ターミナル
  - Terminal.app -> iTerm2 -> wezterm -> alacritty -> wezterm(2026)
  - :o: wezterm
    - aerospace との組み合わせで最高の選択
  - :x: alacritty
    - aerospace と相性が悪い
  - :x: ghostty
    - aerospace と相性が悪い
- プログラミング言語の依存関係マネージャー
  - (plenv, nodeenv など...) -> mise(2025)
  - :o: mise
    - だいたいなんでも mise で管理できるので便利すぎる。
    - PHP だけ管理しにくい問題あり。
- メイン IDE
- :o: goland
- neovim 環境
  - config/.config/neovim/README.md を参照
- ターミナルマルチプレクサ
  - screen -> tmux -> zellij(2026) -> tmux(2026)
  - :o: tmux
    - copy mode が非常に優秀
  - :x: zellij
    - tmux の copy mode の方が zellij より優れている
    - `C-t p l` は `C-t l` より長い
- シェル
  - bash -> zsh -> fish(2025)
  - :o: fish
    - 優れたインタラクティブシェル
    - :( bash と互換性がない
    - しばらく使ったけど、特にメリットないので、zsh に戻したい気もする
  - zsh
  - bash
    - Mac に入ってる Bash はライセンスの関係上絶妙に古いので、そのへん考えるのがめんどくさい。
 - Mac パッケージ管理
   - macports -> brew
- ウェブブラウザ
  - chrome -> vivaldi -> chrome
  - :x: vivaldi
    - そんなにすごく便利っていう感じの機能が特になかった。
