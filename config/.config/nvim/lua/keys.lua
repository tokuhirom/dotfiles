vim.g.mapleader = ","

-- disable number increment/decrement
vim.keymap.set('n', '<C-a>', "<Nop>", {})
vim.keymap.set('n', '<C-x>', "<Nop>", {})

vim.keymap.set('n', 'Y', "yy", {})

-- switch buffers
vim.keymap.set('n', 'gp', ":bp<CR>", {})
vim.keymap.set('n', 'gn', ":bn<CR>", {})
vim.keymap.set('n', 'gd', ":bd<CR>", {})  -- close buffer

-- Jump navigation (ideavim compatible)
vim.keymap.set('n', 'gb', '<C-o>', { desc = 'Go back' })
vim.keymap.set('n', 'gf', '<C-i>', { desc = 'Go forward' })

-- Diagnostic navigation (ideavim compatible)
vim.keymap.set('n', '[q', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']q', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- File tree toggle
vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>", { noremap = true, silent = true })

