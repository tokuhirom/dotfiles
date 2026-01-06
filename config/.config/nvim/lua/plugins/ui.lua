return {
  -- Buffer line
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup{}
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('lualine').setup()
    end,
  },
}
