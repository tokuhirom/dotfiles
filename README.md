# tokuhirom の dotfiles

macOS / Linux 向けの開発環境設定。
dotfiles は `link.sh` で symlink、パッケージは Homebrew (macOS) / apt (Linux) で管理。

## クイックスタート

```bash
cd ~/dotfiles

# dotfiles の symlink を作成
./link.sh

# macOS: Homebrew パッケージをインストール
bin/brew-sync

# Linux: apt でパッケージをインストール
./setup/setup-popos-desktop.sh
```

## 管理方針

### パッケージ管理

| 環境 | 方法 | 設定ファイル |
|------|------|-------------|
| macOS (CLI) | Homebrew | `Brewfile` |
| macOS (GUI) | Homebrew cask | `Brewfile` |
| Mac App Store | mas | `Brewfile` |
| Linux | apt | `setup/setup-popos-desktop.sh` |
| プロジェクト固有 | mise | `config/.config/mise/config.toml`, 各リポジトリの `.mise.toml` |

### Dotfiles
- `link.sh` で `~/dotfiles/config/` から `~/` に素の symlink を作成
- 設定変更は即座に反映
- `bin/` スクリプトは `.zshrc` で PATH に追加済み

## ディレクトリ構造

```
dotfiles/
├── link.sh                # dotfiles の symlink 作成
├── Brewfile               # Homebrew パッケージ定義
├── config/                # dotfiles の実体（link.sh でリンク）
├── bin/                   # カスタムスクリプト
├── setup/                 # OS セットアップスクリプト
├── cheat/                 # チートシート（cheat コマンド用）
└── docs/adr/              # 設計判断の記録
```

## 便利なコマンド

```bash
# dotfiles の symlink を作成
./link.sh

# Homebrew パッケージを同期
bin/brew-sync

# チートシート表示
cheat zellij
cheat mise
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
- プログラミング言語・ツールの管理
  - (plenv, nodeenv など...) -> mise(2025) -> devbox(2026) -> mise(2026)
  - :o: mise
    - github: バックエンドで GitHub Releases から直接バイナリ取得
    - `curl https://mise.run | sh` だけで導入可能
    - チーム導入が容易
  - :x: devbox
    - Nix 必須でチーム導入のハードルが高い
    - トラブル時に Nix の知識が必要
    - Nix ストアからのフェッチが遅い
- メイン IDE
  - :o: goland
- neovim 環境
  - config/.config/nvim/README.md を参照
- ターミナルマルチプレクサ
  - screen -> tmux -> zellij(2026) -> tmux(2026) -> zellij(2026)
  - :x: tmux
    - copy mode が非常に優秀
    - tmux は claude で使うとめっちゃスクロールする謎現象があり｡
  - :o: zellij
    - tmux の copy mode の方が zellij より優れている
    - `C-t p l` は `C-t l` より長い
      - この問題は諸々設定頑張ったら解決した
      - copy mode は相変わらず tmux の方が便利だけど
- シェル
  - bash -> zsh -> fish(2025) -> zsh(2026-)
  - :x: fish
    - 優れたインタラクティブシェル
    - :( bash と互換性がない
    - しばらく使ったけど、特にメリットないので、zsh に戻したい気もする
  - zsh
    - 結局 fish から zsh に戻した
  - bash
    - Mac に入ってる Bash はライセンスの関係上絶妙に古いので、そのへん考えるのがめんどくさい。
- Mac パッケージ管理
  - macports -> brew -> Nix(2026) -> brew(2026)
  - :o: Homebrew
    - Brewfile で宣言的に管理
    - GUI アプリも cask で管理可能
- dotfiles 管理
  - シェルスクリプト (link.sh, setup-*.sh) -> Nix(2026) -> link.sh(2026)
  - :o: link.sh（symlink）
    - 設定ファイルは素の symlink で即座に反映
    - シンプルで理解しやすい
- ウェブブラウザ
  - chrome -> vivaldi -> chrome
  - :x: vivaldi
    - そんなにすごく便利っていう感じの機能が特になかった。
    - chrome に縦タブ来るらしいし
