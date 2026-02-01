# tokuhirom の dotfiles

Nix による宣言的な設定管理で、再現可能な開発環境を構築します。

## 🚀 クイックスタート

### 自動インストール（推奨）

```bash
cd ~/dotfiles
./install-nix.sh
```

このスクリプトは以下を自動的に実行します:
1. Determinate Systems インストーラーを使用して Nix をインストール
2. 環境を設定
3. **マシン固有設定 (`~/.config/nix/machines.nix`) を自動生成**
4. dotfiles 設定を自動的に適用

**マシン設定について:**
- `~/.config/nix/machines.nix` は現在のユーザー名とホスト名で自動生成されます
- git リポジトリの外にあるため、誤ってコミットされることがない
- 複数マシンで使う場合は、各マシンで `./install-nix.sh` を実行すれば OK

## 特徴

- ✅ **完全に宣言的**: すべての設定がコードで管理
- ✅ **再現可能**: どのマシンでも同じ環境を構築
- ✅ **アトミックロールバック**: 問題があれば即座に元に戻せる
- ✅ **クロスプラットフォーム**: macOS と Linux で同じ設定を共有
- ✅ **プライバシー**: ホスト名とユーザー名はリポジトリ外で管理
- ✅ **220+ パッケージ**: 宣言的に管理
- ✅ **開発環境**: mise、Git、Neovim、ビルド依存関係が自動セットアップ

## 管理されている内容

### パッケージ管理
- **macOS**: CLI ツール（Nix）、GUI アプリ（Homebrew Casks）、Mac App Store アプリ
- **Linux**: 基本パッケージ（apt）、apt にないモダンなツール（Nix）
- **共通**: Git、Zsh、Neovim の設定は home-manager の `programs.*` で管理

### Dotfiles
- 設定ファイルは `link.sh` で素の symlink を作成（`~/dotfiles/config/` → `~/`）
- bin/ スクリプトは PATH に追加（`.zshrc` で `$HOME/dotfiles/bin` を設定済み）
- プラットフォーム固有の設定を自動適用

### 開発環境
- **Git**: 完全な設定（ユーザー情報、エイリアス、diff/merge 設定）
- **Zsh**: 補完、履歴、シンタックスハイライト、mise 自動 activation
- **Neovim**: lazy.nvim 設定を維持
- **mise**: 言語バージョン管理
- **ビルド依存関係**: gcc、make、ライブラリなど自動インストール

### macOS システム設定
- ダークモード、キーリピート、Dock、Finder 設定
- CapsLock → Control マッピング
- キーボードショートカット設定

## ディレクトリ構造

```
dotfiles/
├── flake.nix              # Nix flake エントリーポイント
├── flake.lock             # 自動生成されるロックファイル（git コミット済み）
├── machines.nix.example   # マシン設定のテンプレート
├── install-nix.sh         # Nix 自動インストールスクリプト
├── darwin/                # macOS システム設定
│   ├── default.nix        # メイン設定
│   ├── packages.nix       # CLI ツール
│   ├── homebrew.nix       # GUI アプリ
│   └── system-settings.nix # システムデフォルト設定
├── home/                  # ユーザー環境（home-manager）
│   ├── default.nix        # メイン home-manager 設定
│   ├── common.nix         # 共通設定（imports、環境変数、xdg）
│   ├── darwin.nix         # macOS 固有パッケージ
│   ├── linux.nix          # Linux 固有パッケージ（apt にないもの）
│   ├── development.nix    # 開発用ビルド依存関係
│   └── programs/          # プログラム固有の設定
│       ├── git.nix        # Git 設定
│       ├── zsh.nix        # Zsh 設定（mise activation 含む）
│       └── neovim.nix     # Neovim 設定
├── config/                # dotfiles の実体（link.sh でシンボリックリンク）
├── bin/                   # カスタムスクリプト
├── setup/                 # OS セットアップスクリプト
├── link.sh                # dotfiles の symlink 作成スクリプト
└── legacy/                # 廃止されたスクリプト（参照用）
```

## 便利なコマンド

```bash
# dotfiles の symlink を作成
./link.sh

# Nix 設定を適用
./apply-nix.sh

# flake inputs を更新（nixpkgs、home-manager など）
nix flake update

# 変更内容を確認（ドライラン）
home-manager switch --flake . --dry-run  # Linux
darwin-rebuild check --flake .           # macOS

# 古い世代をクリーンアップ
nix-collect-garbage --delete-older-than 30d

# パッケージを検索
nix search nixpkgs <package-name>
```

## ロールバック

問題が発生した場合:

**Linux:**
```bash
# 世代をリスト表示
home-manager generations

# 前の世代にロールバック
home-manager switch --flake . --rollback
```

**macOS:**
```bash
# 世代をリスト表示
darwin-rebuild --list-generations

# ロールバック
darwin-rebuild --rollback
```

## 検証

設定を適用した後:

```bash
# Nix で管理されているパッケージを確認
which git neovim tmux ripgrep bat jq fd gh fzf

# /nix/store/... を指しているはず

# パッケージバージョンを確認
git --version
nvim --version
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
   - macports -> brew -> Nix(2026)
   - :o: Nix
     - 完全に宣言的で再現可能
     - アトミックロールバックが便利
     - クロスプラットフォーム（macOS と Linux で同じ設定）
- dotfiles 管理
  - シェルスクリプト (link.sh, setup-*.sh) -> Nix(2026) -> link.sh + Nix(2026)
  - :o: link.sh（symlink） + Nix（パッケージ・プログラム設定）
    - 設定ファイルは素の symlink で即座に反映
    - パッケージと programs.* 設定は Nix で宣言的に管理
    - Linux は apt + Nix（apt にないもののみ）のハイブリッド
- ウェブブラウザ
  - chrome -> vivaldi -> chrome
  - :x: vivaldi
    - そんなにすごく便利っていう感じの機能が特になかった。
    - chrome に縦タブ来るらしいし

## 注意事項

- 初回セットアップ後、`mise install` を手動で実行して言語をインストール
- すべての nix コマンドには `--impure` フラグが必要（~/.config/nix/machines.nix を読むため）
- Flakes はデフォルトで有効（Determinate インストーラー使用）

## 従来のセットアップ（廃止）

古い Brewfile などは `legacy/` ディレクトリに移動されています。
`link.sh` と `setup/` スクリプトは現役で使用中です。

