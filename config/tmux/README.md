# tmux Configuration

## Prefix

`C-t` (Ctrl+t)

## 基本操作

| Key | Action |
|-----|--------|
| `C-t c` / `C-t C-c` | 新しいウィンドウ |
| `C-t n` / `C-t C-n` | 次のウィンドウ |
| `C-t p` / `C-t C-p` | 前のウィンドウ |
| `C-t C-t` | 直前のウィンドウ |
| `C-t -` | 水平分割 |
| `C-t \|` | 垂直分割 |

## ペーン操作 (tmux-pain-control)

| Key | Action |
|-----|--------|
| `C-t h/j/k/l` | ペーン移動 |
| `C-t H/J/K/L` | ペーンリサイズ |
| `C-t C-h/j/k/l` | ペーンリサイズ（細かく） |

## コピーモード

| Key | Action |
|-----|--------|
| `C-t [` | コピーモード開始 |
| `C-t ]` | ペースト |
| `Space` | 選択開始（コピーモード中） |
| `Enter` | 選択終了・コピー |

vi キーバインド（`h/j/k/l` で移動）

## 設定リロード

```
C-t r
```

## プラグイン

- tmux-sensible: 基本設定
- tmux-pain-control: ペーン操作
- tmux-yank: システムクリップボード連携

## 既知の問題

### Claude Code との組み合わせ

Claude Code を tmux 内で使用すると、以下の問題が発生することがある:

- **画面切り替え時の大量スクロール**: ペーン/ウィンドウ切り替え時にスクロールが走る
- **パフォーマンス劣化**: 長時間使用でスクロールバックバッファが蓄積し重くなる
- **スクロールイベント過多**: 4,000-6,700/秒のスクロールイベントが発生

**回避策:**
1. 定期的に `/quit` で Claude Code を再起動
2. Claude Code は専用ペーンで使用し、git 等は別ペーンで実行
3. `history-limit` を小さめに設定（根本解決ではない）

**関連 Issue:**
- https://github.com/anthropics/claude-code/issues/4851
- https://github.com/anthropics/claude-code/issues/9935
- https://github.com/anthropics/claude-code/issues/3648

Claude Code 側の修正待ちの状態（2025年1月時点）
