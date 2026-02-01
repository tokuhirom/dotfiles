# devbox チートシート

## 基本コマンド

```bash
# パッケージ追加
devbox add <package>
devbox add yq-go@latest
devbox add nodejs@20

# シェルに入る
devbox shell

# コマンド実行
devbox run <command>

# 初期化
devbox init
```

## パッケージ検索

### nixhub.io
https://www.nixhub.io/

パッケージ名とバージョンの確認用。詳細情報は少ない。

### search.nixos.org（推奨）
https://search.nixos.org/packages

description, homepage, license が見える。

### nix コマンドで詳細確認

```bash
# メタ情報全部
nix eval nixpkgs#yq-go.meta --json | jq

# ホームページ
nix eval nixpkgs#yq-go.meta.homepage --raw

# 説明
nix eval nixpkgs#yq-go.meta.description --raw

# 定義ファイルの場所
nix eval nixpkgs#yq-go.meta.position --raw
```

## 似た名前のパッケージの見分け方

例: `yq` vs `yq-go`

```bash
# それぞれの homepage を確認
nix eval nixpkgs#yq.meta.homepage --raw
# → https://github.com/kislyuk/yq (Python, jq wrapper)

nix eval nixpkgs#yq-go.meta.homepage --raw
# → https://mikefarah.gitbook.io/yq/ (Go, standalone)
```

## devbox.json の例

```json
{
  "packages": [
    "go@1.22",
    "nodejs@20",
    "yq-go@latest"
  ],
  "shell": {
    "init_hook": [
      "echo 'Welcome to devbox!'"
    ]
  }
}
```

## 自分専用の devbox 設定（チームのリポジトリで）

チームのリポジトリに devbox.json をコミットしたくない場合、
`.git/info/exclude` を使ってローカルだけで無視できる。

```bash
# 1. リポジトリで devbox を初期化
devbox init

# 2. 自分用のパッケージを追加
devbox add just@latest go-task@latest mkcert@latest

# 3. .git/info/exclude に追加してコミット対象外にする
echo 'devbox.json' >> .git/info/exclude
echo 'devbox.lock' >> .git/info/exclude
echo '.devbox/' >> .git/info/exclude
```

`.git/info/exclude` は `.gitignore` と同じ書式だが、
ローカルにしか効かずリポジトリにコミットされない。

## Tips

- `@latest` で最新バージョン
- `@20` のようにメジャーバージョン指定可能
- 内部的には nixpkgs を使用（再現性が高い）
