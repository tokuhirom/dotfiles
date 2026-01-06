# Neovim Configuration

モダンな IDE スタイルの Neovim 設定。

## 必要要件

- Neovim 0.11.0 以上
- Git
- Node.js (LSP サーバー用)
- tree-sitter CLI

## インストール

```bash
# dotfiles をリンク (既にリンク済みの場合はスキップ)
ln -s ~/dotfiles/config/.config/nvim ~/.config/nvim

# Neovim を起動するとプラグインが自動インストールされる
nvim
```

## プラグイン一覧

### プラグインマネージャー
- **lazy.nvim** - モダンなプラグインマネージャー

### UI
- **tokyonight.nvim** - カラースキーム
- **bufferline.nvim** - バッファタブ表示
- **lualine.nvim** - ステータスライン
- **nvim-web-devicons** - アイコン表示

### ファイル操作
- **nvim-tree.lua** - ファイルツリー（左側に表示）
- **telescope.nvim** - ファジーファインダー（**Ctrl-p で起動するのはこれ！**）
  - ファイル検索、grep、バッファ一覧など

### LSP・補完
- **mason.nvim** - LSP サーバー管理
- **mason-lspconfig.nvim** - mason と lspconfig の連携
- **nvim-lspconfig** - LSP クライアント設定
- **neodev.nvim** - Neovim Lua API の補完・型情報
- Neovim 0.11 ネイティブ補完 - nvim-cmp の代わりに使用

### シンタックスハイライト
- **nvim-treesitter** - Tree-sitter ベースのハイライト

### その他
- **vim-just** - Justfile のサポート

## キーバインド

### 基本

| キー | 機能 |
|------|------|
| `,` | Leader キー |

### ファイル操作

| キー | 機能 | プラグイン |
|------|------|-----------|
| `,e` | ファイルツリーをトグル | nvim-tree |
| `Ctrl-p` | ファイル検索 (git リポジトリ内) | telescope |
| `,fg` | grep 検索 | telescope |
| `,fb` | バッファ一覧 | telescope |
| `,fn` | Neovim 設定ファイル検索 | telescope |

### バッファ操作

| キー | 機能 |
|------|------|
| `gp` | 前のバッファ |
| `gn` | 次のバッファ |
| `,bd` | バッファを閉じる |

### LSP

| キー | 機能 |
|------|------|
| `gd` | 定義へジャンプ |
| `gD` | 宣言へジャンプ |
| `gr` | 参照を検索 |
| `gi` | 実装へジャンプ |
| `K` | ホバー情報を表示 |
| `Ctrl-k` | シグネチャヘルプ |
| `,rn` | リネーム |
| `,ca` | コードアクション |
| `,f` | フォーマット |
| `,D` | 型定義へジャンプ |

### その他

| キー | 機能 |
|------|------|
| `Y` | 行をヤンク |
| `.#` (Insert モード) | コメント用の区切り線を挿入 |

## LSP サーバー

自動インストールされる言語サーバー：
- **lua_ls** - Lua
- **ts_ls** - TypeScript/JavaScript
- **pyright** - Python
- **rust_analyzer** - Rust
- **gopls** - Go

追加でサーバーをインストールする場合：
```vim
:Mason
```

## Telescope の使い方

**Ctrl-p** で起動するファジーファインダーです。

### 基本操作
- 起動後、ファイル名を入力して絞り込み
- `Ctrl-n` / `Ctrl-p` または矢印キーで選択
- `Enter` で開く
- `Esc` でキャンセル

### 検索モード
- `,fg` - プロジェクト全体を grep 検索
- `,fb` - 開いているバッファから選択

## ファイルツリー (nvim-tree)

`,e` でトグル。基本操作：
- `Enter` - ファイルを開く
- `a` - 新規ファイル作成
- `d` - 削除
- `r` - リネーム
- `x` - カット
- `c` - コピー
- `p` - ペースト
- `?` - ヘルプ

## トラブルシューティング

### プラグインが動かない
```vim
:Lazy sync
```

### LSP が動かない
```vim
:Mason
# サーバーをインストール
```

### 設定を再読み込み
```vim
:source ~/.config/nvim/init.lua
```

## 設定ファイル構造

```
~/.config/nvim/
├── init.lua                 # メイン設定
├── lua/
│   ├── opts.lua            # オプション設定
│   ├── keys.lua            # キーマップ
│   ├── lazy-bootstrap.lua  # lazy.nvim のブートストラップ
│   └── plugins/            # プラグイン設定
│       ├── colorscheme.lua
│       ├── ui.lua
│       ├── file-explorer.lua
│       ├── telescope.lua
│       ├── lsp.lua
│       ├── completion.lua
│       ├── treesitter.lua
│       ├── neodev.lua
│       └── misc.lua
```
