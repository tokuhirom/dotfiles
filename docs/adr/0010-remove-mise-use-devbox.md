# ADR-0010: mise を廃止し devbox に統一

## ステータス
採用

## コンテキスト
ランタイム（Go, Node, Python 等）のバージョン管理に mise を使っていた。
一方、プロジェクト固有のツール管理には devbox を導入済み (ADR-0004)。
両者の役割が重複しており、管理が二重になっていた。

## 決定
mise を廃止し、ランタイム管理も devbox で行う。

### 変更内容
- `home/linux.nix`, `home/darwin.nix` から mise パッケージを削除
- `config/.zshrc` から `mise-activate` 関数を削除
- `link.sh` から `config/.config/mise/config.toml` の symlink を削除
- 設定ファイル (`config/.config/mise/`) は念のため残す

## 理由
- devbox でランタイム管理もできるため mise と役割が重複
- プロジェクトごとに devbox.json でツール・ランタイムを一元管理できる
- グローバルなランタイムバージョン管理が不要になり、構成がシンプルになる

## 結果
- 各プロジェクトで `devbox init` + `devbox add` でランタイムを管理する
- チームリポジトリでは `.git/info/exclude` で devbox ファイルをローカル無視する
