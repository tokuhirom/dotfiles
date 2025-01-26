local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
    -- colorschema
    Plug 'folke/tokyonight.nvim'

    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'akinsho/bufferline.nvim'

    Plug 'ctrlpvim/ctrlp.vim'

    -- nvim-tree を有効にしていると起動がめちゃくちゃ遅くなる
--  Plug 'nvim-tree/nvim-tree.lua'
--  Plug 'nvim-tree/nvim-web-devicons' -- optional, for file icons

    -- " LSPクライアント
    Plug 'neovim/nvim-lspconfig'

    Plug "NoahTheDuke/vim-just"

    -- like airline
    Plug 'nvim-lualine/lualine.nvim'

vim.call('plug#end')

