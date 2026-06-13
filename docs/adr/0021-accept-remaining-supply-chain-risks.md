# ADR-0021: 残存する外部コード取得経路を許容範囲として明文化する

## ステータス

採用

## コンテキスト

supply chain risk の棚卸し (ADR-0016〜0020) で、commit 固定や撤去を行った後も
いくつかの外部コード取得経路が残っている。これらを個別に検討し、
「どこまでを許容するか」の線引きを記録しておく。

## 決定

以下の経路は現状のまま許容する。

### ベンダー公式の curl | sh インストーラ

- `setup/setup-mise.sh`: `curl https://mise.run | sh`
- `setup/setup-claude.sh`: `curl claude.ai/install.sh | bash`
- `setup/setup-mac.sh`: Homebrew 公式インストーラ

いずれもベンダーが公式に案内している手順そのもので、実行されるのは
新規マシンのセットアップ時のみ。checksum 検証を自前で足してもベンダー側の
配布基盤が侵害されれば意味がなく、コストに見合わないため許容する。

### mason の LSP サーバーと treesitter のパーサー

(mason は ADR-0022 で撤去した。以下の記述のうち現在も有効なのは
treesitter パーサーの部分のみ)

lazy-lock.json (ADR-0020) の管轄外で、mason-registry や各言語の公式リリースから
バイナリ・パーサーを取得する。インストールは `:Mason` や `:TSInstall` による
明示的な操作時のみで、勝手に更新はされない。エコシステムの標準的な配布経路
であり、個別 pin は運用コストに見合わないため許容する。

### パッケージマネージャのレジストリ

- Brewfile (Homebrew)
- mise の tools (全てバージョン指定済み。タグベースだが妥当な水準)
- emacs init.el の MELPA (使用頻度が低い。fish (ADR-0019) と同様に
  撤去も考えられるが、init.el は設定ファイル保持ルールに従い残す)

レジストリ自体を信頼する前提で許容する。バージョン固定ができるものは
固定済み。

### 低リスクの git clone

- `setup/setup-alacritty.sh`: alacritty-theme (テーマの toml のみで実行コードなし)
- `setup/setup-plenv.sh`: tokuhirom/plenv, tokuhirom/Perl-Build (自己所有リポジトリ)

## 理由

supply chain 対策は「実行されるコードの取得経路」のリスクとレビューコストの
バランスで決める。エディタプラグインのように「無数の個人リポジトリの HEAD に
追従し、起動のたびに必ず実行される」ものは固定・撤去した (ADR-0016〜0020)。
一方、ベンダー公式の配布基盤や主要レジストリまで信頼しないのは個人の dotfiles
として過剰であり、ここを線引きとする。

## 結果

- 今回の棚卸しはこれで完了とする
- 新しい外部コード取得経路を追加する場合は、この線引きに従って
  commit 固定 / vendoring / 許容のいずれかを判断し、ADR に記録する
