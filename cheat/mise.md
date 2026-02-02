# mise チートシート

## 基本コマンド

```bash
# ツールのインストール（config.toml / .mise.toml に基づく）
mise install

# グローバルにバージョン設定
mise use --global node@22
mise use --global go@1.23

# プロジェクトローカルに設定（.mise.toml を作成）
mise use node@22

# インストール済みツール一覧
mise list

# 利用可能なバージョン一覧
mise list-all node

# 診断
mise doctor
```

## github: バックエンド

GitHub Releases から直接バイナリをインストール（プラグイン不要）。

```toml
# .mise.toml または config.toml
[tools]
"github:BurntSushi/ripgrep" = "latest"
"github:goreleaser/goreleaser" = "1.25.1"

# バイナリ名がリポジトリ名と違う場合
"github:BurntSushi/ripgrep" = { version = "latest", exe = "rg" }
```

## 設定ファイル

```bash
# グローバル設定
~/.config/mise/config.toml

# プロジェクトローカル設定
.mise.toml          # 推奨
.tool-versions      # asdf 互換
```

## プロジェクトでの使い方

```bash
# プロジェクトで mise を初期化
cd ~/work/my-project
mise use node@22 go@1.23

# .mise.toml が作成される
# チームメンバーは mise install するだけ
```

## Tips

```bash
# 現在のツールパスを確認
mise where node

# シェルで一時的にバージョンを変更
mise shell node@20

# プラグイン不要のツール一覧（mise registry）
mise registry
```
