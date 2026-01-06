return {
  'folke/neodev.nvim',
  ft = 'lua',
  opts = {
    library = {
      plugins = { 'nvim-treesitter', 'plenary.nvim', 'telescope.nvim' },
      types = true,
    },
  },
}
