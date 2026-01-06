vim.g.mapleader = ","

-- disable number increment/decrement
vim.keymap.set('n', '<C-a>', "<Nop>", {})
vim.keymap.set('n', '<C-x>', "<Nop>", {})

vim.keymap.set('n', 'Y', "yy", {})

-- switch buffers
vim.keymap.set('n', 'gp', ":bp<CR>", {})
vim.keymap.set('n', 'gn', ":bn<CR>", {})
vim.keymap.set('n', '<leader>bd', ":bd<CR>", {})  -- changed from 'gd' to avoid conflict with LSP goto definition

-- File tree toggle
vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>", { noremap = true, silent = true })

