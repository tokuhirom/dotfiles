# dotfiles プロジェクト用 Claude 指示

## 基本ルール

### ドキュメント言語
- **すべてのドキュメントは日本語で記述すること**
- README.md、NIX_README.md、各種設定ファイルの説明文など、すべて日本語で書く
- コード内のコメントも日本語を推奨

### 設定ファイルの保持
- **アプリをアンインストールしても設定ファイル（`config/.config/` 以下）は残す**
- また使う可能性があるため、設定ファイルは削除しない

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

**ADR-0015: macOS では Homebrew を優先する**

### パッケージの追加場所

| 種類 | 追加先 | 例 |
|------|--------|-----|
| CLI ツール | `Brewfile` の `brew` | fzf, ripgrep, bat |
| GUI アプリ（Cask） | `Brewfile` の `cask` | wezterm, 1password |
| Mac App Store | `Brewfile` の `mas` | Xcode, LINE |
| Homebrew にないもの | `darwin/packages.nix` | （現在なし） |

### Homebrew の適用

```bash
# Brewfile を同期（インストール + 不要パッケージ削除）
bin/brew-sync
```

### 注意事項

- **macOS では Homebrew を優先**（Nix は Homebrew にないパッケージのみ）
- nix-darwin はシステム設定と dotfiles リンクの管理に使用
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
- `cheat xremap` - xremap (Linux)

## bin/ コマンド

便利なコマンドは `bin/` に追加する:
- `app-toggle <bundle-id> <app-name>` - アプリを workspace 1/9 間でトグル
- `brew-sync` - Brewfile を同期（インストール + 不要パッケージ削除）
- `cheat <name>` - 設定ファイルのチートシート表示

## Git 運用

このリポジトリでは **main ブランチに直接コミット** してよい。PR を作成する必要はない。

## 設定の適用

```bash
# 設定を適用（ログは ~/.local/share/nix-logs/ に保存）
./apply-nix.sh

# 初回セットアップ
./install-nix.sh
```

### 設定変更後のアナウンス

`config/` 以下の設定ファイルを変更した場合、ユーザーに `./apply-nix.sh` の実行を促すこと。

```
設定を反映するには `./apply-nix.sh` を実行してください。
```

## macOS 設定

macOS のシステム設定は `setup/setup-mac-settings.sh` で管理。

```bash
# macOS 設定を適用
./setup/setup-mac-settings.sh
```

## ADR (Architecture Decision Records)

設定変更の意思決定を `docs/adr/` に記録する。

### ADR を書くタイミング

- 新しいツール・アプリを追加するとき
- 既存のツールを別のものに置き換えるとき
- 設定の方針を変更するとき

### ADR のフォーマット

```markdown
# ADR-NNNN: タイトル

## ステータス
採用 / 却下 / 廃止

## コンテキスト
なぜこの決定が必要になったのか

## 決定
何を決定したか

## 理由
なぜその決定をしたか

## 結果
この決定によって何が変わるか
```

### 運用ルール

- ファイル名: `NNNN-kebab-case-title.md`（例: `0001-add-hammerspoon.md`）
- Claude は変更理由が不明な場合、ユーザーに質問してから ADR を作成する
- 軽微な変更（typo 修正、バージョン更新など）は ADR 不要
