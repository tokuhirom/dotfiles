return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,  -- treesitter does not support lazy-loading
  build = ':TSUpdate',
  config = function()
    -- Install parsers
    require('nvim-treesitter').install({
      'lua',
      'vim',
      'vimdoc',
      'javascript',
      'typescript',
      'python',
      'rust',
      'go',
      'html',
      'css',
      'json',
      'yaml',
      'markdown',
      'bash',
    })

    -- Enable highlighting for all filetypes
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
