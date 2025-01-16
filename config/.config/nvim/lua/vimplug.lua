local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
    -- colorschema
    Plug 'folke/tokyonight.nvim'

    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'akinsho/bufferline.nvim'

    Plug 'ctrlpvim/ctrlp.vim'

    Plug 'nvim-tree/nvim-tree.lua'
    Plug 'nvim-tree/nvim-web-devicons' -- optional, for file icons

    -- " LSPクライアント
    Plug 'neovim/nvim-lspconfig'


    -- like airline
    Plug 'nvim-lualine/lualine.nvim'

vim.call('plug#end')

