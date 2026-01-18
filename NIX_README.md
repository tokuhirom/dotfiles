# Nix 設定

この dotfiles リポジトリは、宣言的なシステムとユーザー環境管理のために Nix へ移行中です。

## クイックスタート

### 1. マシン設定（初回のみ）

```bash
# テンプレートを ~/.config/nix/ にコピー（リポジトリの外）
# これによりホスト名とユーザー名をプライベートに保つ
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

Determinate インストーラーの特徴:
- デフォルトで flakes が有効
- アンインストールのサポートが優れている
- 公式インストーラーよりも信頼性が高い

### 2. 設定の適用

**Linux の場合:**
```bash
cd ~/dotfiles

# 初回セットアップ - flake.lock が作成されます
# ~/.config/nix/machines.nix で設定した username@hostname を使用
# --impure は プライベートな machines.nix の読み込みを許可
# --print-build-logs はダウンロード/ビルドの進捗を表示
nix run home-manager/master --impure --print-build-logs -- switch --flake .#username@hostname

# 初回実行後は、インストールされた home-manager を使用可能
home-manager switch --impure --flake .#username@hostname
```

**macOS の場合:**
```bash
cd ~/dotfiles

# まず ~/.config/nix/machines.nix で Mac を設定
# （上記ステップ1を参照）

# 初回セットアップ
# --impure はプライベートな machines.nix の読み込みを許可
nix run nix-darwin --impure --print-build-logs -- switch --flake .#your-mac-hostname

# 初回実行後
darwin-rebuild switch --impure --flake .#your-mac-hostname
```

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
    ├── README.md          # 移行状況の説明
    ├── Brewfile           # 旧 Homebrew 設定
    ├── link.sh            # 旧シンボリックリンク作成スクリプト
    └── setup/             # 旧セットアップスクリプト
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

## 便利なコマンド

```bash
# flake inputs を更新（nixpkgs、home-manager など）
nix flake update

# 変更内容を確認（ドライラン）
home-manager switch --flake . --dry-run  # Linux
darwin-rebuild check --flake .           # macOS

# ダウンロード/ビルドの進捗を表示（任意の nix コマンドに追加）
nix run <package> --print-build-logs
home-manager switch --flake . --show-trace  # 詳細なエラートレースを表示

# 古い世代をクリーンアップ
nix-collect-garbage --delete-older-than 30d

# パッケージを検索
nix search nixpkgs <package-name>

# ダウンロード中の内容をリアルタイムで確認
nix build --print-build-logs --verbose <package>
```

## Tips とベストプラクティス

### ダウンロード進捗の表示

デフォルトでは、Nix はダウンロード中に何も表示しないことがあります。常にこれらのフラグを使用してください:

```bash
# nix run コマンドの場合
nix run <package> --print-build-logs

# home-manager/darwin-rebuild の場合
home-manager switch --flake . --show-trace
darwin-rebuild switch --flake . --show-trace
```

`install-nix.sh` スクリプトは自動的にこれらのフラグを含んでいます！

## 注意事項

- **Flakes はデフォルトで有効** Determinate インストーラーを使用
- **進捗の可視性**: ダウンロードを確認するために `--print-build-logs` を使用
- **既存のシェルスクリプトは引き続き動作** 移行中も使用可能
- **Homebrew は削除されません** - Nix パッケージが PATH で優先される
- **link.sh は引き続き動作** - Phase 3 で置き換え済み
- **すべての setup/*.sh スクリプトはまだ必要** - 後のフェーズで置き換え予定
