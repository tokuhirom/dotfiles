# ADR-0007: dotfiles の symlink 管理を home-manager から素の symlink に移行

## ステータス
採用

## コンテキスト
これまで dotfiles（設定ファイル）の symlink 管理を home-manager の `home.file` で行っていた。
しかし、`home.file` は Nix Store 経由の間接 symlink を作成するため、以下の問題があった:

- symlink 先が Nix Store のパスになり、デバッグ時にわかりにくい
- `apply-nix.sh` を実行しないと設定変更が反映されない
- home-manager の activation が重くなる
- 単純なファイルリンクのために Nix の評価が必要になる

以前は `link.sh` で素の symlink を管理していたが、home-manager 導入時に統合した経緯がある。

## 決定
dotfiles の symlink 管理を `link.sh` に戻す。
パッケージ管理（`home.packages`）と `programs.*` 設定は引き続き Nix/home-manager で管理する。

### 変更内容
- `link.sh` を復活（旧 `link.sh` のパターンをベースに現在の `home.file` の内容を統合）
- `home/common.nix` から `home.file` ブロック、`home.sessionPath`、`home.activation.createVimTmp` を削除
- `home/linux.nix` から `home.file` ブロックを削除
- `home/darwin.nix` から `home.file` ブロックを削除
- `home/programs/neovim.nix` から `home.file` 行を削除

## 理由
- 設定ファイルの変更が即座に反映される（`~/dotfiles/config/` を直接編集すれば済む）
- symlink 先が `~/dotfiles/config/...` と明確で、トラブルシューティングが容易
- Nix の責務をパッケージ管理とプログラム設定に限定し、単純化できる
- `link.sh` は冪等で、何度実行しても安全

## 結果
- dotfiles の symlink は `./link.sh` で管理する
- 初回セットアップ時は `./link.sh` の実行が必要
- `bin/` スクリプトは PATH に通すだけで済む（`.zshrc` で `$HOME/dotfiles/bin` を PATH に追加済み）
- `~/.local/bin/` への symlink は不要になった
