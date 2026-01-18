# tokuhirom の dotfiles

Nix による宣言的な設定管理で、再現可能な開発環境を構築します。

## 🚀 クイックスタート

### 1. マシン設定（初回のみ）

```bash
# テンプレートを ~/.config/nix/ にコピー（リポジトリの外）
mkdir -p ~/.config/nix
cp ~/dotfiles/machines.nix.example ~/.config/nix/machines.nix

# マシン情報を編集
vim ~/.config/nix/machines.nix
```

`~/.config/nix/machines.nix` の例:
```nix
{ mkLinuxHome, mkDarwinHost }:
{
  homeConfigurations = {
    "yourname@laptop" = mkLinuxHome {
      username = "yourname";
      hostname = "laptop";
    };
  };
}
```

**なぜ `~/.config/nix/` なのか？**
- git リポジトリの外にあるため、誤ってコミットされることがない
- Nix ユーザー設定の標準的な場所
- 公開する dotfiles リポジトリに表示されない

### 2. Nix のインストールと設定の適用

**最も簡単な方法 - 自動インストール:**
```bash
cd ~/dotfiles
./install-nix.sh
```

このスクリプトは以下を実行します:
1. Determinate Systems インストーラーを使用して Nix をインストール
2. 環境を設定
3. dotfiles 設定を自動的に適用

## 手動インストール

### 1. Nix のインストール（Determinate インストーラー - 推奨）

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### 2. 設定の適用

**Linux の場合:**
```bash
cd ~/dotfiles

# 初回セットアップ - flake.lock が作成されます
# --impure は プライベートな machines.nix の読み込みを許可
# --print-build-logs はダウンロード/ビルドの進捗を表示
nix run home-manager/master --impure --print-build-logs -- switch --flake .#username@hostname

# 初回実行後は、インストールされた home-manager を使用可能
home-manager switch --impure --flake .#username@hostname
```

**macOS の場合:**
```bash
cd ~/dotfiles

# 初回セットアップ
nix run nix-darwin --impure --print-build-logs -- switch --flake .#your-mac-hostname

# 初回実行後
darwin-rebuild switch --impure --flake .#your-mac-hostname
```

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
- **macOS**: 100+ CLI ツール、47 GUI アプリ（Homebrew Casks）、10 Mac App Store アプリ
- **クロスプラットフォーム**: 60+ CLI ツール（Git、Neovim、tmux、ripgrep、bat など）
- **Linux**: i3、polybar、fcitx5、フォントなど

### Dotfiles
- すべての設定ファイルが home-manager で管理
- 22 個の bin/ スクリプトが ~/.local/bin にリンク
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
├── home/                  # ユーザー環境（クロスプラットフォーム）
│   ├── default.nix        # メイン home-manager 設定
│   ├── common.nix         # クロスプラットフォーム設定
│   ├── darwin.nix         # macOS 固有のユーザー設定
│   ├── linux.nix          # Linux 固有のユーザー設定
│   ├── development.nix    # 開発用ビルド依存関係
│   └── programs/          # プログラム固有の設定
│       ├── git.nix        # Git 設定
│       ├── zsh.nix        # Zsh 設定（mise activation 含む）
│       └── neovim.nix     # Neovim 設定
├── config/                # dotfiles の実体（Nix から参照）
├── bin/                   # カスタムスクリプト
└── legacy/                # 廃止されたスクリプト（参照用）
```

## 便利なコマンド

```bash
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

- **ターミナル**: wezterm（aerospace との組み合わせで最高）
- **プログラミング言語管理**: mise（だいたいなんでも管理できて便利）
- **メイン IDE**: GoLand
- **エディタ**: Neovim（lazy.nvim）
- **ターミナルマルチプレクサ**: tmux（copy mode が優秀）
- **シェル**: zsh
- **Mac パッケージ管理**: Nix + Homebrew（GUI アプリ）
- **ウェブブラウザ**: Chrome

## 注意事項

- 初回セットアップ後、`mise install` を手動で実行して言語をインストール
- すべての nix コマンドには `--impure` フラグが必要（~/.config/nix/machines.nix を読むため）
- Flakes はデフォルトで有効（Determinate インストーラー使用）

## 従来のセットアップ（廃止）

古いセットアップスクリプト（link.sh、Brewfile、setup-*.sh）は `legacy/` ディレクトリに移動されました。
新規インストールには Nix を使用してください。
