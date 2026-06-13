# vim プラグイン セキュリティ監査記録

`.vimrc` で commit 固定している全 vim プラグイン (ADR-0016, ADR-0024) の
ソースコードを supply chain security の観点で監査した記録。

## 監査日

2026-06-13

## 監査範囲・観点

各プラグインの pin した commit に固定された状態の全ファイル
(`.git/` 除く) を対象に、以下を確認した:

1. ネットワーク通信 (外部 URL、curl/wget/socket/HTTP、データ送信)
2. 任意コード実行 (`system()`/`job_start()`/`execute()`/`eval` への信頼できない入力)
3. modeline / autocmd 経由でファイルを開いただけで走るコード
4. 難読化 (base64 等のペイロード、不自然な長い 1 行)
5. 情報送信 (認証情報・環境変数・ファイル内容の外部送信)
6. バイナリ・実行ファイルの有無とその正体
7. 既知の危険パターン (shellescape 漏れによるコマンドインジェクション等)

各プラグインを個別のエージェントで並列に精査した。事前に、各プラグインの
実体 (`~/.vim/plugged/`) の HEAD が `.vimrc` の pin と一致することを確認済み。

## 総合結果

**全 10 プラグインが CLEAN。** バックドア・悪意あるコード・難読化・意図しない
外部通信・情報窃取の痕跡は、いずれにも認められなかった。

| プラグイン | pin commit | 判定 | 備考 |
|-----------|-----------|------|------|
| gruvbox | 697c0029 | CLEAN | 色定義のみ。`*.sh` 2 本は OSC エスケープで端末パレットを設定する手動 source 用ヘルパー |
| ctrlp.vim | 86872f02 | CLEAN | 外部コマンド (find/ag/git/ctags) はユーザー設定由来、引数は shellescape 済み |
| minibufexpl.vim | ad72976c | CLEAN | `system()` はデフォルト無効の debug mode 2 のローカルログのみ |
| vim-go | fc429c8e | CLEAN | 外部ツール呼び出しは util.vim に集約・argv は shellescape。`:GoPlay` のみ公式 Playground へ明示的 POST |
| vim-perl | 25ecb006 | CLEAN | 構文定義中心。ftplugin の `perl -e` は @INC 取得のみ (cwd-perl 回避チェックあり) |
| vim-cpanfile | d69eb9ae | CLEAN | ftdetect + 構文定義のみ。外部コマンド実行なし |
| perl-local-lib-path.vim | 5cdf5f22 | CLEAN | `'path'` への追加のみ。`system()` は固定の archname 取得 (shellescape 済み) |
| vim-markdown | 40091fc1 | CLEAN | Tim Pope 由来の最小構成。プレビュー機能自体なし |
| quickfixstatus | fd3875b9 | CLEAN | quickfix を読んで echo するだけ。コード実行・通信なし |
| editorconfig-vim | 13b86c5c | CLEAN | `.editorconfig` の値は setbufvar 経由のみ、execute/eval/system へ渡らない |

## プラグイン別の所見

### gruvbox (697c0029)
純粋なカラースキーム。唯一の `execute` は内部の静的な色テーブルから
highlight コマンドを組み立てるもので、外部入力の流入なし。autocmd 定義は
皆無。実行ビット付きの `*.sh` 2 本は OSC 4 エスケープで 256 色パレットを
設定するヘルパーで、ユーザーが手動 source した時のみ動作しプラグイン読み込み時には走らない。

### ctrlp.vim (86872f02)
ファジーファインダー。外部コマンド実行は 3 箇所 (user_command via find/ag/git、
buffertag の ctags) で、いずれもコマンドテンプレートはユーザー設定由来、
補間されるパスは `shellescape()`/`fnameescape()` 済み。`eval()` は ctrlp 内部
データのみを対象。MRU 等の書き込みはローカルキャッシュのみ。`.ctrlpignore` の
値が `&wildignore` に影響しうるがコード実行には至らない (option 代入のみ)。

### minibufexpl.vim (ad72976c)
バッファ一覧 UI。`system()` は `g:miniBufExplDebugMode == 2` (非デフォルト) 時に
プラグイン自身のデバッグ文字列をローカルファイルへ追記するだけ。約 24 の `exec`
は内部の数値バッファ ID から組み立てるバッファ操作コマンドのみ。autocmd は
バッファ管理の範囲内。

### vim-go (fc429c8e)
大規模プラグイン (約 160 ファイル) を精査。コマンド実行は `go#util#Exec` に
集約され、リスト形式 argv を shellescape 済みで渡す設計。外部送信は `:GoPlay`
実行時の公式 Go Playground (go.dev) への POST のみ (明示的なユーザー操作)。
`localhost` 参照は gopls のデバッグサーバ。`:GoInstallBinaries` は公式 Go ツール
群を `go install` するもので、ハードコードされた import path に不審なものなし、
ファイルを開いただけでは走らない。`scripts/` 配下はメンテナ向け CI スクリプトで
利用時に自動実行されない。バイナリは `assets/vim-go.png` (ロゴ) のみ。

### vim-perl (25ecb006)
構文ハイライト + ftplugin。ランタイムで走る唯一の実行は ftplugin の
`system("perl -e 'print join(q/,/,@INC)'")` で、@INC 取得して `path` を補完する
だけ。しかも「cwd の perl を実行しない」安全チェック付き。`socket`/`Net::` 等の
ヒットはすべて Perl 組み込み関数名の構文定義。`tools/`・`build-corpus.pl` 等は
メンテナが手動実行する開発スクリプトでプラグイン読み込み時には動かない。
`contrib/` はデフォルトでは読み込まれない。

### vim-cpanfile (d69eb9ae)
全 6 ファイル・103 行。ftdetect の autocmd (filetype 設定) と宣言的な構文定義
(`syn keyword`/`hi def link`)・単語辞書のみ。外部コマンド実行が一切ないため
インジェクションの余地もない。

### perl-local-lib-path.vim (5cdf5f22)
3 ファイルのみ。プロジェクトルートを上方探索し `lib`/`extlib` 等を `'path'` に
追加するだけ。`system()` は固定の archname 取得クエリ (shellescape 済み)。
※ `setlocal path+=` でパス値を未エスケープ挿入する堅牢性バグはあるが、
操作対象はローカルのディレクトリ名と `'path'` に限定され、コード実行・情報送信には繋がらない。

### vim-markdown (40091fc1, tokuhirom 自作)
3 ファイル・134 行。Tim Pope のオリジナルベースの最小構成。プレビュー機能・
外部レンダラ呼び出しが実装自体に存在せず、`system()`/`eval` も 0 件。
`runtime! ftplugin/html.vim` は標準ランタイムの読み込みで外部プロセス起動ではない。

### quickfixstatus (fd3875b9)
2 ファイル・62 行。`getqflist()`/`getloclist()` を読んで現在行のエラーを `echo`
するだけ。`system()`/`eval`/`execute()`・ネットワーク・環境変数アクセスは皆無。
`&cpo` 退避復元・`g:loaded_*` ガードといった作法も正規。

### editorconfig-vim (13b86c5c)
信頼境界 (悪意ある `.editorconfig` でコード注入できるか) を重点監査。
`.editorconfig` の値は固定正規表現でパースされ Dictionary に格納、適用は
`setbufvar(bufnr, '&option', value)` 経由で数値は `str2nr()` 強制変換・文字列は
ハードコードされたリテラルとの比較のみ。**editorconfig の値が
`execute`/`eval`/`system` に渡る経路は存在しない**。`external_command` モードは
明示的オプトインが必要でデフォルト無効、コマンドは両引数 shellescape 済み。

## 補足・運用

- この監査は pin した commit 時点の内容に対するもの。プラグインを更新
  (ハッシュ書き換え) する際は、upstream の差分をレビューした上で、必要に応じて
  該当プラグインを再監査すること
- 監査で「正当な外部コマンド呼び出し」と判断した箇所 (vim-go の go ツール群、
  ctrlp の find/ag、vim-perl/perl-local-lib-path の perl 実行) は、いずれも
  ユーザーの明示的操作またはローカル環境情報の取得に限定される
