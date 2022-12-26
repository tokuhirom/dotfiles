vim.g.mapleader = ","

vim.keymap.set('n', 'Y', "yy", {})

-- switch buffers
vim.keymap.set('n', 'gp', ":bp<CR>", {})
vim.keymap.set('n', 'gn', ":bn<CR>", {})
vim.keymap.set('n', 'gd', ":bd<CR>", {})

