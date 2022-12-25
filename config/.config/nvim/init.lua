-- :PackerInstall to install plugins.

-- https://github.com/nvim-tree/nvim-tree.lua
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


require('opts')
require('keys')
require('packer-init')
require('plugins/telescope')
require('plugins/bufferline')
require('plugins/nvim-tree')
require('plugins/lualine')
require('plugins/mason')
require('plugins/cmp')
vim.cmd('colorscheme tokyonight')

