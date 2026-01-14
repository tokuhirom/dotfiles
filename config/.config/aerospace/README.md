# AeroSpace Configuration

## Workspaces

| Workspace | 用途 |
|-----------|------|
| 1 | メイン表示（display 1） |
| 2 | サブモニター（display 2） |
| 0 | 待避用（ウィンドウを隠す） |

## App Toggle

特定のアプリを `ctrl-alt-{key}` でトグル表示/非表示できる。

### Workspace 1 (メインモニター)

| Key | App |
|-----|-----|
| `ctrl-alt-t` | WezTerm |
| `ctrl-alt-b` | Chrome (Browser) |
| `ctrl-alt-g` | GoLand |
| `ctrl-alt-v` | VSCode |

### Workspace 2 (サブモニター)

| Key | App |
|-----|-----|
| `ctrl-alt-o` | Obsidian |
| `ctrl-alt-s` | Slack |
| `ctrl-alt-l` | LINE |
| `ctrl-alt-j` | Logseq |
| `ctrl-alt-z` | Zoom |
| `ctrl-alt-c` | Calendar |

### 動作詳細

- アプリが起動していない → 起動して指定の workspace に配置
- 起動中でフォーカスあり → workspace 0 に移動（待避）
- 起動中でフォーカスなし → 指定の workspace に移動してフォーカス

### 起動時の自動配置

AeroSpace 起動時に各アプリは自動的に指定の workspace に配置される（`on-window-detected` + `if.during-aerospace-startup`）。

## Window Navigation

| Key | Action |
|-----|--------|
| `alt-h` | 左のウィンドウにフォーカス |
| `alt-j` | 下のウィンドウにフォーカス |
| `alt-k` | 上のウィンドウにフォーカス |
| `alt-l` | 右のウィンドウにフォーカス |

## Window Move

| Key | Action |
|-----|--------|
| `alt-shift-h` | ウィンドウを左に移動 |
| `alt-shift-j` | ウィンドウを下に移動 |
| `alt-shift-k` | ウィンドウを上に移動 |
| `alt-shift-l` | ウィンドウを右に移動 |

## Workspace Navigation

| Key | Action |
|-----|--------|
| `alt-1` | ワークスペース 1 に移動 |
| `alt-2` | ワークスペース 2 に移動 |
| `alt-tab` | 直前のワークスペースに戻る |

## Window to Workspace

| Key | Action |
|-----|--------|
| `alt-shift-1` | ウィンドウをワークスペース 1 に移動 |
| `alt-shift-2` | ウィンドウをワークスペース 2 に移動 |
| `alt-shift-0` | ウィンドウをワークスペース 0 に移動（待避） |
| `alt-shift-tab` | ワークスペースを次のモニターに移動 |

## Monitor Assignment

| Workspace | Monitor |
|-----------|---------|
| 1 | モニター 1 (メイン) |
| 2 | モニター 2 (サブ) |

## Resize

| Key | Action |
|-----|--------|
| `alt-minus` | スマートリサイズ -50 |
| `alt-equal` | スマートリサイズ +50 |

## Layout

| Key | Action |
|-----|--------|
| `alt-slash` | tiles (horizontal/vertical) |
| `alt-comma` | accordion (horizontal/vertical) |

## Service Mode

`alt-shift-;` で service モードに入る。

| Key | Action |
|-----|--------|
| `esc` | 設定リロード & main モードに戻る |
| `r` | レイアウトをリセット |
| `f` | floating/tiling 切り替え |
| `backspace` | 現在以外のウィンドウを閉じる |

## Key Notation

- `alt` = Option
- `shift` = Shift
- `ctrl` = Control
