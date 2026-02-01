# ADR-0009: 共通パッケージを OS 別管理に分割

## ステータス
採用

## コンテキスト
`home/common.nix` の `home.packages` で macOS/Linux 共通の CLI パッケージを Nix で管理していた。
しかし Linux (Pop!_OS) では apt で入るパッケージが大半で、Nix で管理する必要性が薄い。
また `darwin/packages.nix` との重複も多く、管理が煩雑になっていた。

## 決定
`home/common.nix` の `home.packages` を廃止し、OS 別に管理する。

- **Linux**: apt で入るものは `setup/setup-popos-desktop.sh` で管理。apt にないもの（bottom, yq-go, kind, k9s, awscli2, go-task, just, sops, mkcert, duckdb, nix-direnv, devbox, mise, zellij, docker-client）のみ `home/linux.nix` で Nix 管理
- **macOS**: `home/darwin.nix` で Nix 管理（`darwin/packages.nix` とは別に home-manager 側で管理）

## 理由
- Linux では apt でシステムワイドにインストールすれば十分なパッケージが多い
- Nix の評価・ビルドコストを減らせる
- OS ごとに最適なパッケージマネージャを使い分けるほうがシンプル
- `common.nix` は imports と環境変数のみに責務を限定できる

## 結果
- `home/common.nix` にはパッケージ定義がなくなり、imports・環境変数・xdg 設定のみ
- Linux のパッケージ追加は apt (`setup/setup-popos-desktop.sh`) が第一選択
- apt にないツールのみ `home/linux.nix` で Nix 管理
- macOS のパッケージは `home/darwin.nix` と `darwin/packages.nix` で管理
