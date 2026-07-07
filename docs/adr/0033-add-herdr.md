# ADR-0033: herdr を導入しキーバインドを tmux に合わせる

## ステータス
採用

## コンテキスト
複数の AI コーディングエージェント（Claude Code / Codex / opencode など）を
並行して動かす機会が増え、それらのセッションを束ねて管理したくなった。
これまで tmux / zellij で端末を多重化していたが、エージェント単位の
ワークスペース・エージェント状態表示・リモート (SSH) アタッチといった
AI エージェント運用に特化した機能が欲しくなった。

herdr は「AI コーディングエージェント向けのターミナルワークスペースマネージャ」で、
永続セッション・エージェント多重化・worktree 連携・エージェント状態の可視化を備える。
Homebrew でインストール済み。

## 決定
- herdr を dotfiles 管理下に置く。
- 設定 `config/.config/herdr/config.toml` を `~/.config/herdr/config.toml` に
  **ファイル単位で** symlink する（mise `[dotfiles]`）。
- キーバインドは既存の `~/.tmux.conf`（`config/.tmux.conf`）を踏襲する。
  - prefix は tmux と同じ `Ctrl+t`。
  - tab（tmux の window 相当）操作を `c`/`p`/`n`、pane 移動を `h/j/k/l`、
    分割を `-`（上下）/`v`（左右）に割り当てる。
  - 設定リロードは `prefix r`（tmux の `bind r`）。

## 理由
- **既存の指の記憶を活かす**: tmux を長く使っているため、prefix と主要操作を
  合わせておけば学習コストがほぼゼロで移行できる。
- **ファイル単位 symlink**: herdr は `~/.config/herdr/` 配下にソケットや
  ログ・`session.json` を書き込むため、ディレクトリごとリンクすると
  ランタイム生成物と衝突する。`config.toml` だけをリンクして実ディレクトリは残す。
- **tmux にない機能はそのまま**: workspace / worktree 操作など herdr 固有の
  機能は herdr のデフォルトキー（`prefix w` / `prefix Shift+g` など）を採用する。

## 結果
- `mise dotfiles apply` で herdr 設定が symlink される。
- `cheat herdr` でキーバインド一覧を参照できる。
- 一部は tmux と完全一致しない:
  - `|`（パイプ）は端末依存で不安定なため、左右分割は `prefix v` に割当。
  - prefix と同じ `Ctrl+t` を prefix 後に押すと literal prefix 扱いになるため、
    last-window 相当は `prefix t` にした。
  - tmux のリサイズ（`C-h/j/k/l` 直接）に相当するものは herdr では
    リサイズモード（`prefix Shift+r` → `h/j/k/l`）になる。
- tmux / zellij は引き続き併用可能（置き換えではなく追加）。
