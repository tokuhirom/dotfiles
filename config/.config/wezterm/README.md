# WezTerm Configuration

## Copy/Paste

| Key | Action |
|-----|--------|
| `Alt+C` | コピー |
| `Ctrl+Shift+C` | コピー |
| `Alt+V` | ペースト |
| `Ctrl+Shift+V` | ペースト |

## Copy Mode

`Ctrl+Shift+[` で Copy Mode に入る（vim ライクな選択モード）

### Navigation

| Key | Action |
|-----|--------|
| `h/j/k/l` | 左/下/上/右 |
| `w/b` | 次/前の単語 |
| `e` | 単語末尾 |
| `0/$` | 行頭/行末 |
| `^` | 最初の非空白文字 |
| `g` | バッファ先頭 |
| `G` | バッファ末尾 |
| `H/M/L` | 画面の上/中/下 |
| `Ctrl+u/d` | 半ページ上/下 |
| `Ctrl+b/f` | 1ページ上/下 |

### Selection

| Key | Action |
|-----|--------|
| `v` | 文字選択開始 |
| `V` | 行選択開始 |
| `Ctrl+v` | 矩形選択開始 |
| `o` | 選択範囲の反対側へ |

### Copy & Exit

| Key | Action |
|-----|--------|
| `y` | コピーしてモード終了 |
| `Esc/q` | キャンセル |

### Search (in Copy Mode)

| Key | Action |
|-----|--------|
| `/` | 前方検索 |
| `?` | 後方検索 |
| `n/N` | 次/前の検索結果 |

## QuickSelect

`Ctrl+Shift+Space` で QuickSelect モード

画面上の URL、パス、Git ハッシュ、IP アドレスなどがハイライトされ、
表示されたキーを押すとクリップボードにコピーされる。

## Mouse

- ダブルクリック: 単語選択
- トリプルクリック: 行選択
- ドラッグ: 範囲選択
- `Ctrl+クリック`: リンクを開く
