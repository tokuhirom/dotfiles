-- Neovim Configuration with lazy.nvim

-- Basic settings
require('opts')
require('keys')

-- Bootstrap lazy.nvim
require('lazy-bootstrap')

-- Load plugins
require('lazy').setup('plugins', {
  ui = {
    border = 'rounded',
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- Custom keybindings
vim.api.nvim_set_keymap('i', '.#', '# -------------------------------------------------------------------------', { noremap = true, silent = true })
