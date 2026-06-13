# ADR-0022: mason を撤去し LSP サーバーを外部インストールにする

## ステータス

採用

## コンテキスト

supply chain risk の棚卸し (ADR-0016〜0021) では、mason がダウンロードする
LSP サーバーのバイナリを「許容」としていた (ADR-0021)。しかしそもそも
mason 自体が不要との判断になった。

mason は LSP サーバーを mason-registry 経由で npm / PyPI / GitHub Releases
などから自動取得する仕組みで、便利な反面:

- 取得物が lazy-lock.json (ADR-0020) の管轄外で、バージョン管理の枠から外れる
- mise / brew / rustup / npm など、既に使っているツールチェーンと
  インストール経路が二重になる
- nvim の中に独自のパッケージ取得経路が増える分、攻撃面も増える

## 決定

mason.nvim と mason-lspconfig.nvim を撤去し、LSP サーバーは外部
(mise / brew / rustup / npm など) でインストールする。

`lua/plugins/lsp.lua` では nvim 0.11 の `vim.lsp.enable()` を使い、
PATH 上にコマンドが存在するサーバーだけを有効化する。サーバーの実体が
なくてもエラーにはならず、その言語の LSP が動かないだけになる。

## 理由

- 使っていないなら、独自のバイナリ取得経路を維持するリスクとコストは不要
  (ADR-0018, 0019 と同じ判断基準)
- LSP サーバーのインストールを他のツールと同じ経路 (mise や brew) に寄せる
  ことで、バージョン管理の方法が一本化される
- `vim.lsp.enable()` + nvim-lspconfig のデフォルト設定で、mason-lspconfig が
  やっていたサーバー有効化は代替できる

## 結果

- 各 LSP サーバーは手動インストールが必要になった。コマンド名と
  インストール例は `config/.config/nvim/README.md` に記載
- lazy-lock.json から mason.nvim / mason-lspconfig.nvim のエントリを削除した。
  既存マシンでは `:Lazy clean` で実体を削除できる
- mason がインストール済みのサーバー (`~/.local/share/nvim/mason/`) は
  PATH から外れるため使われなくなる。気になる場合は手動で削除する
- ADR-0021 の「mason の LSP サーバー」の項は本 ADR により不要になった
  (treesitter パーサーの扱いは ADR-0021 のまま)
