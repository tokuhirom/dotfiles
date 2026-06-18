# ADR-0031: plenv を廃止し perl を mise で管理する

## ステータス
採用

## コンテキスト
これまで perl のバージョン管理は plenv で行っていた。`setup/setup-plenv.sh`
が `tokuhirom/plenv` と `tokuhirom/Perl-Build` を `~/.plenv` に git clone し、
zsh / fish の起動時に `plenv init` を eval していた。

一方で ADR-0023 以降、ツールのバージョンは mise (`config.toml` / `mise.lock`)
に一本化する方針を進めており、すでに `perl = '5.42.0'` が mise で管理されて
いた。perl のバージョン管理機構が plenv と mise で二重になっていた。

## 決定
plenv を廃止し、perl は mise に一本化する。具体的には次を削除した。

- `setup/setup-plenv.sh`（plenv / Perl-Build の git clone スクリプト）
- `mise.toml` bootstrap タスクからの `./setup/setup-plenv.sh` 呼び出し
- `config/zsh/init/lang/perl.sh` の `~/.plenv` PATH 追加と `plenv init`
- `config/.config/fish/config.fish` の plenv 初期化ブロック

`perl.sh` に残っている `PERL_CPANM_OPT` などの環境変数は plenv とは無関係なので
維持する。`config/.vimrc` の ctrlp ignore パターン中の `plenv` 文字列は無害な
コメント相当のため放置する。

## 理由
- perl のバージョン管理を mise に一本化し、二重管理を解消する（ADR-0023 と整合）。
- `setup-plenv.sh` は ADR-0021 で「自己所有リポジトリの supply chain リスク受容」
  として記録していたが、撤去によりこのリスク自体が消える。
- シェル起動時の `plenv init` eval が不要になり、起動が軽くなる。

## 結果
- perl のバージョンは今後 `config/.config/mise/config.toml` の `perl` で管理する。
- 既存マシンに残る `~/.plenv` は自動では消えない。不要なら手動で
  `rm -rf ~/.plenv` する（設定の互換性のため本リポジトリからは削除しない）。
- ADR-0021 が列挙していた supply chain リスク対象から `setup-plenv.sh` が外れる。
