-- :PackerInstall

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = { { 'nvim-tree/nvim-web-devicons' } }
    }

--  use {
--      'nvim-telescope/telescope.nvim', tag = '0.1.0',
--      requires = { {'nvim-lua/plenary.nvim'} }
--  }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)

        -- 'r' to rename the file.
    }

    -- LSP server installer
    -- https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
--  use 'williamboman/mason.nvim'    
--  use 'williamboman/mason-lspconfig.nvim'

    -- lsp
--  use 'neovim/nvim-lspconfig' 
    use {
        'neoclide/coc.nvim' ,
        branch = "release"
    }

    -- rust
    use {
        'simrat39/rust-tools.nvim',
        ft = { 'rust' },
        config = function ()
            local rt = require("rust-tools")

            rt.setup({
                server = {
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                        -- Code action groups
                        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                    end,
                },
            })
        end
    }

    use {
        'ctrlpvim/ctrlp.vim',
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use {
        'w0rp/ale',
        ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
        cmd = 'ALEEnable',
        config = 'vim.cmd[[ALEEnable]]'
    }


    -- Completion framework:
    use 'hrsh7th/nvim-cmp' 

    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'

    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'                             
    use 'hrsh7th/cmp-path'                              
    use 'hrsh7th/cmp-buffer'                            
    use 'hrsh7th/vim-vsnip'         

    -- filer
    use 'lambdalisue/fern.vim'
end)


