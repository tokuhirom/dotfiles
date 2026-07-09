# herdr

AI コーディングエージェント向けのターミナルワークスペースマネージャ。
永続セッション・エージェント多重化・リモート (SSH) アタッチができる。

- 設定ファイル: `config/.config/herdr/config.toml`（`~/.config/herdr/config.toml` に symlink）
- 起動: `herdr`（永続セッションに attach/作成）
- 設定反映: `herdr server reload-config` または prefix+r
- キーを既定に戻す: `herdr config reset-keys`

## キーバインド

`~/.tmux.conf` を踏襲している。**prefix は `Ctrl+t`**（tmux と同じ）。
以下はすべて prefix を押してから続けて入力する。

### tab（tmux の window 相当）

| キー | 動作 | tmux 対応 |
|------|------|-----------|
| `prefix c` | 新しい tab | new-window |
| `prefix p` | 前の tab | previous-window |
| `prefix n` | 次の tab | next-window |
| `prefix t` | 直前の pane へ | last-window の代替 |
| `prefix 1..9` | 番号の tab へ | select-window |
| `prefix Shift+x` | tab を閉じる | |
| `prefix Shift+t` | tab をリネーム | |

### pane

| キー | 動作 | tmux 対応 |
|------|------|-----------|
| `prefix -` | 上下に分割 | bind - split-window |
| `prefix v` | 左右に分割 | bind \| split-window -h |
| `prefix h/j/k/l` | pane フォーカス移動 | select-pane -L/D/U/R |
| `prefix Tab` / `prefix Shift+Tab` | pane 巡回 | |
| `prefix x` | pane を閉じる | kill-pane |
| `prefix Shift+r` | リサイズモード | C-h/j/k/l resize の代替 |
| `prefix Shift+p` | pane をリネーム | |
| `prefix e` | スクロールバック閲覧 | copy-mode (bind [) |

### workspace（herdr 固有）

| キー | 動作 |
|------|------|
| `prefix w` | workspace ピッカー |
| `prefix Shift+n` | 新しい workspace |
| `prefix Shift+w` | workspace リネーム |
| `prefix Shift+d` | workspace を閉じる |
| `prefix Shift+g` | git worktree を作成 |

### カスタムコマンド（`[[keys.command]]`）

| キー | 動作 |
|------|------|
| `prefix z` | カレントディレクトリを zed で開く（`zed .`） |

`type = "shell"` はバックグラウンド実行（GUI 向き）、`type = "pane"` は一時 pane を開いて
コマンド終了時に閉じる（TUI 向き。例: lazygit）。

### その他

| キー | 動作 |
|------|------|
| `prefix r` | 設定リロード（tmux: bind r） |
| `prefix ?` | ヘルプ |
| `prefix q` | detach |
| `prefix b` | サイドバー表示トグル |
| `prefix g` | goto |
| `prefix o` | 通知ターゲットを開く |

## メモ

- `|`（パイプ）は端末依存で不安定なため、左右分割は `v`(ertical) に割り当てている。
- prefix と同じキー（`Ctrl+t`）を prefix 後に押すと「literal prefix 送出」扱いになるため、
  last-window 相当は `prefix t` にしている。
- `prefix z` は元々 zoom（pane 最大化）だったが、あまり使わないため zed 起動に振り替えた。
