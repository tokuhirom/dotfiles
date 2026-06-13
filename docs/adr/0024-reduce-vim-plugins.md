# ADR-0024: vim プラグインを 31 個から 10 個に削減する

## ステータス

採用

## コンテキスト

ADR-0016 で全プラグインを commit hash で固定した際、「使っていないプラグインの
削減も別途検討する」を今後の課題としていた。pin したとはいえ、プラグインは
起動のたびに実行されるサードパーティコードであり、数が少ないほど
レビュー対象も攻撃面も小さくなる。

`.vimrc` の設定・マッピング・依存関係を分析し、使用実態を確認した上で削減した。

## 決定

以下の 21 個を削除し、10 個を残す。

### 削除: 機能していなかったもの

- **vim-snippets** - スニペットエンジン (UltiSnips) がコメントアウト済みで動かない
- **yankround.vim** - マッピングが一切なく履歴にアクセスする手段がなかった
- **vim-clang-format** - clang-format 連携は外部コマンド `%! clang-format` を
  直接呼んでおりプラグイン不使用
- **vimproc.vim** - 依存するプラグインが存在しない
- **vim-godef** - vim-go 自体の定義ジャンプと重複

### 削除: 使わなくなった言語・技術のもの

- **vala.vim** (kkc 用)、**vim-scala**、**gyp.vim**、**vim-less**、
  **vim-p6doc** (Perl 6。`.vimrc` 内の Perl 6 自動検出コードも削除)、
  **ansible-vim**、**scss-syntax.vim**、**plantuml-syntax**、
  **vim-javascript**、**vim-toml** (新しめの vim は標準で TOML 対応)

### 削除: UI 系

- **vim-airline** - `.vimrc` 自前の statusline / anzu の statusline 設定と競合していた
- **rainbow_parentheses.vim** - リポジトリが長年放置されている。設定ブロックも削除
- **xterm-color-table.vim** - 使用実態なし

### 削除: 検索系 (当初は残したが追加で削除)

- **clever-f.vim** - `f`/`t` の繰り返しジャンプ強化。使っていなかった
- **vim-anzu** - 検索件数 (`n/m`) 表示。`.vimrc` に `n`/`N`/`*`/`#` の
  マッピングがあったため当初は使用中と分類して残したが、実際には使って
  いなかったため削除した。代わりに vim 標準の `set shortmess-=S` で
  `[3/17]` 形式の件数表示を有効にし、関連マッピングと statusline 設定も削除

### 残す (10 個)

gruvbox (colorscheme), ctrlp, minibufexpl,
vim-go, vim-perl, vim-cpanfile, perl-local-lib-path, vim-markdown (自作),
quickfixstatus, editorconfig-vim

minibufexpl は分析上は削除候補だったが、使用しているため残した。

## 理由

- supply chain risk は pin (ADR-0016) で軽減済みだが、プラグイン数そのものを
  減らすことで更新時のレビュー対象と攻撃面を最小化する
- 「機能していないもの」はリスクだけあって利益がない (ADR-0018, 0019 と同じ基準)

## 結果

- 残存 10 プラグインで vim が正常起動し、意図したプラグインだけが
  読み込まれることを確認済み
- 各マシンでは `:PlugClean` を実行すると削除済みプラグインの実体が
  `~/.vim/plugged/` から消える
- 削除した言語を再び書くようになったら、その時点の commit で pin して入れ直す
