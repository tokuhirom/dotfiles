# ADR-0026: Neovim プラグインを精査して削減する

## ステータス
採用

## コンテキスト
vim プラグインの精査（ADR-0024, ADR-0025）に続き、Neovim 側のプラグイン構成も
見直した。lazy.nvim 管理下に 18 個のプラグインがあったが、以下の問題があった。

1. **補完が二重に動いていた**
   `lua/plugins/lsp.lua` の `LspAttach` で Neovim 0.11 のネイティブ補完
   (`vim.lsp.completion.enable(..., { autotrigger = true })`) を有効化している
   一方で、`nvim-cmp` + 各種 `cmp-*` ソース（計 7 プラグイン）も導入されており、
   LSP 補完候補が二重に出る／競合する構成になっていた。

2. **neodev.nvim が deprecated かつ実質機能していなかった**
   - 公式に非推奨（後継は lazydev.nvim）。
   - `lsp.lua` の `dependencies` と `neodev.lua` で二重宣言されていた。
   - 新しい `vim.lsp.enable()` 方式では neodev の lspconfig フックが効かず、
     Lua API の型補完が実際には効いていなかった。

3. **見た目系・ファイラがミニマル方針と合っていなかった**
   bufferline.nvim / lualine.nvim / nvim-tree.lua は壊れてはいないが、
   「本当に必要なものだけを残す」方針では削減対象だった。ファイル探索は
   telescope で代替できる。

## 決定
以下のプラグインを削除し、ネイティブ機能・telescope に寄せる。

| 削除 | 理由 |
|------|------|
| nvim-cmp + cmp-nvim-lsp / cmp-buffer / cmp-path / cmp-cmdline / cmp-vsnip / vim-vsnip | Neovim 0.11 ネイティブ補完に一本化（二重化解消） |
| neodev.nvim | deprecated・機能不全 |
| bufferline.nvim | バッファタブはネイティブ UI で十分 |
| lualine.nvim | ステータス行はネイティブ UI で十分 |
| nvim-tree.lua | ファイル探索は telescope で代替 |
| nvim-web-devicons | 上記の依存としてのみ存在していたため不要に |

残すプラグイン（9 個）:
tokyonight.nvim / nvim-lspconfig / nvim-treesitter / telescope.nvim +
plenary.nvim / gitsigns.nvim / Comment.nvim / vim-just / lazy.nvim。

補完は `lua/opts.lua` の `completeopt = {menuone, noselect, noinsert}` を活かし、
`vim.lsp.completion`（autotrigger）に一本化する。

## 理由
- 補完の二重化はバグであり、ネイティブ補完に寄せることで競合を解消できる。
- neodev は機能していなかったため、削除しても挙動は変わらない。
- ミニマル志向では、装飾系・ファイラは標準機能と telescope で代替できる。
- supply chain risk（ADR-0016〜0021）の観点でも、管理対象プラグインが
  18 → 9 個に減ることは望ましい。

## 結果
- `lua/plugins/` から completion.lua / neodev.lua / ui.lua / file-explorer.lua を削除。
- `lua/plugins/lsp.lua` から neodev 依存を除去。
- `lua/keys.lua` から nvim-tree のキーマップ（`,e`）を削除。
- `lazy-lock.json` から削除プラグインのエントリを除去。
- README.md のプラグイン一覧・キーバインド・ディレクトリ構成を更新。
- 反映には Neovim 起動後 `:Lazy clean`（不要プラグインの削除）を実行する。
- Lua 設定の型補完が必要になった場合は、後継の lazydev.nvim 導入を別途検討する。
