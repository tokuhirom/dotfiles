# tokuhirom の dotfiles

macOS / Linux 向けの開発環境設定。
セットアップは `mise bootstrap` に一本化 (ADR-0027)。dotfiles の symlink は mise の
`[dotfiles]`、ツールは mise の `[tools]`、OS パッケージは Homebrew (macOS) / apt (Linux)。

## クイックスタート

```bash
cd ~/dotfiles

# OS を検出して mise bootstrap を実行 (dotfiles symlink + tools + OS パッケージ)
./setup.sh

# dotfiles の symlink だけを適用したいとき
mise dotfiles apply -E macos   # macOS
mise dotfiles apply -E linux   # Linux

# 適用状態の確認 / プレビュー
mise dotfiles status -E linux
mise bootstrap -E linux --dry-run
```

> 真っさらなマシンでツールが入りきらない場合は `./setup.sh` をもう一度実行するか
> `mise install` を実行する (ADR-0027 参照)。

## 管理方針

### パッケージ管理

| 環境 | 方法 | 設定ファイル |
|------|------|-------------|
| macOS (CLI) | Homebrew | `Brewfile` |
| macOS (GUI) | Homebrew cask | `Brewfile` |
| Mac App Store | mas | `Brewfile` |
| Linux | apt | `setup/setup-popos-desktop.sh` |
| ツール (言語・CLI) | mise | `config/.config/mise/config.toml`, 各リポジトリの `.mise.toml` |

### Dotfiles
- mise の `[dotfiles]` で `~/dotfiles/config/` から `~/` に symlink を作成 (ADR-0027)
  - 共通: `mise.toml`、OS 固有: `mise.macos.toml` / `mise.linux.toml`
- `mise dotfiles status` で適用状態を確認できる
- 設定変更は symlink なので即座に反映
- `bin/` スクリプトは `.zshrc` で PATH に追加済み

## ディレクトリ構造

```
dotfiles/
├── setup.sh               # セットアップの入口 (mise bootstrap -E <os> を呼ぶ)
├── mise.toml              # bootstrap / 共通 dotfiles 定義 (ADR-0027)
├── mise.macos.toml        # macOS 固有 dotfiles
├── mise.linux.toml        # Linux 固有 dotfiles
├── Brewfile               # Homebrew パッケージ定義
├── config/                # dotfiles の実体（mise [dotfiles] でリンク）
├── bin/                   # カスタムスクリプト
├── setup/                 # OS セットアップスクリプト (bootstrap タスクから呼ぶ)
├── cheat/                 # チートシート（cheat コマンド用）
└── docs/adr/              # 設計判断の記録
```

## 便利なコマンド

```bash
# セットアップ (dotfiles + tools + OS パッケージ)
./setup.sh

# dotfiles の symlink だけ適用 / 状態確認
mise dotfiles apply -E linux
mise dotfiles status -E linux

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
  - シェルスクリプト (link.sh, setup-*.sh) -> Nix(2026) -> link.sh(2026) -> mise bootstrap(2026)
  - :o: mise bootstrap（mise の [dotfiles]）
    - ツールが既に mise 管理なのでセットアップの入口を 1 つにできる
    - 設定ファイルは symlink で即座に反映、`mise dotfiles status` で状態確認できる
    - OS 別設定ファイル (mise.{macos,linux}.toml) でクロスプラットフォーム維持
- ウェブブラウザ
  - chrome -> vivaldi -> chrome
  - :x: vivaldi
    - そんなにすごく便利っていう感じの機能が特になかった。
    - chrome に縦タブ来るらしいし
