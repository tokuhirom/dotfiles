# ADR-0018: tpm (tmux plugin manager) を削除する

## ステータス

採用

## コンテキスト

supply chain risk の棚卸し (ADR-0016, ADR-0017 の続き) で、`setup/setup-tmux.sh` が
tpm (tmux-plugins/tpm) を master HEAD で `git clone` していることがわかった。

しかし `.tmux.conf` を確認したところ `@plugin` の記述も tpm の起動行
(`run '~/.tmux/plugins/tpm/tpm'`) も存在せず、**tpm は clone されるだけで
一切使われていなかった**。

## 決定

`setup/setup-tmux.sh` を削除し、tpm をセットアップ対象から外す。

## 理由

- 使っていないコードを未 pin で取得するのは、リスクだけあって利益がない
- tmux プラグインが将来必要になった場合は、その時点で commit pin した形で
  導入し直せばよい (ADR-0016 の方針に従う)

## 結果

- `setup.sh` から `setup-tmux.sh` の呼び出しを削除した
- 既存マシンの `~/.tmux/plugins/tpm` は使われていないので、手動で
  `rm -rf ~/.tmux/plugins/tpm` してよい (放置しても実害はない)
- `.tmux.conf` 自体は引き続き link.sh で管理する
