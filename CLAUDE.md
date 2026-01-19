# dotfiles プロジェクト用 Claude 指示

## 基本ルール

### ドキュメント言語
- **すべてのドキュメントは日本語で記述すること**
- README.md、NIX_README.md、各種設定ファイルの説明文など、すべて日本語で書く
- コード内のコメントも日本語を推奨

## プロジェクト構造

このプロジェクトは **nix-darwin** と **home-manager** で管理されている。

```
dotfiles/
├── flake.nix              # Nix flake 設定（エントリポイント）
├── apply-nix.sh           # 設定適用スクリプト
├── install-nix.sh         # 初回インストールスクリプト
├── darwin/                # macOS (nix-darwin) 設定
│   ├── default.nix        # nix-darwin メイン設定
│   ├── homebrew.nix       # Homebrew casks/brews（GUI アプリ等）
│   ├── packages.nix       # CLI パッケージ（nixpkgs）
│   └── system-settings.nix # macOS システム設定
├── home/                  # home-manager 設定
│   ├── common.nix         # 共通パッケージ・dotfiles
│   ├── darwin.nix         # macOS 固有設定
│   ├── linux.nix          # Linux 固有設定
│   └── programs/          # プログラム別設定
│       ├── git.nix
│       ├── neovim.nix
│       └── zsh.nix
├── config/                # 設定ファイル（home-manager でリンク）
└── bin/                   # カスタムスクリプト
```

## パッケージ管理

### パッケージの追加場所

| 種類 | 追加先 | 例 |
|------|--------|-----|
| CLI ツール（共通） | `home/common.nix` | fzf, ripgrep, bat |
| CLI ツール（macOS 専用） | `darwin/packages.nix` | colima, mas |
| GUI アプリ（Cask） | `darwin/homebrew.nix` の `casks` | wezterm, 1password |
| Homebrew formula | `darwin/homebrew.nix` の `brews` | sketchybar, borders |
| Mac App Store | `darwin/homebrew.nix` の `masApps` | Xcode, LINE |

### 注意事項

- **zsh/bash はログインシェルなので homebrew で管理**（nix だと壊れた時にログインできなくなる）
- `programs/` 配下で `programs.xxx.enable = true` を使うとより詳細な設定が可能

## 主要な設定ファイルのパス

- **aerospace**: `config/.config/aerospace/aerospace.toml`
- **sketchybar**: `config/.config/sketchybar/sketchybarrc`
- **zellij**: `config/.config/zellij/config.kdl`
- **wezterm**: `config/.config/wezterm/wezterm.lua`
- **zsh**: `config/.zshrc`
- **neovim**: `home/programs/neovim.nix` で管理

## ショートカットキーの設定

ショートカットキーを設定する際は、aerospace のキーバインドと競合しないように注意すること。

aerospace で使用中のキー:
- `Alt + h/j/k/l` - フォーカス移動
- `Alt + Shift + h/j/k/l` - ウィンドウ移動
- `Alt + 1/2` - ワークスペース切り替え
- `Alt + Shift + 1/2/0` - ウィンドウをワークスペースに移動
- `Ctrl + Alt + t/b/g/v` - アプリトグル ws1（WezTerm/Chrome/GoLand/VSCode）
- `Ctrl + Alt + o/s/l/j/z/c` - アプリトグル ws2（Obsidian/Slack/LINE/Logseq/Zoom/Calendar）

設定前に `config/.config/aerospace/aerospace.toml` を確認すること。

## config/.config 下の設定ファイル

`config/.config/` 以下に設定を追加・変更した場合:

1. そのディレクトリに `README.md` を作成してショートカットキーや使い方を記載する
2. `cheat/` ディレクトリにシンボリックリンクを作成して `cheat <name>` でアクセスできるようにする

```bash
# 例: zellij の場合
ln -s ../config/.config/zellij/README.md cheat/zellij.md
```

現在 cheat でアクセスできる設定:
- `cheat aerospace` - aerospace
- `cheat zellij` / `cheat zj` - zellij
- `cheat wezterm` - wezterm

## bin/ コマンド

便利なコマンドは `bin/` に追加する:
- `app-toggle <bundle-id> <app-name>` - アプリを workspace 1/9 間でトグル
- `cheat <name>` - 設定ファイルのチートシート表示

## 設定の適用

```bash
# 設定を適用（ログは ~/.local/share/nix-logs/ に保存）
./apply-nix.sh

# 初回セットアップ
./install-nix.sh
```

## macOS 設定

macOS のシステム設定は `darwin/system-settings.nix` で宣言的に管理。
