return {
  'nvim-tree/nvim-tree.lua',
  dependencies = 'nvim-tree/nvim-web-devicons',
  cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
  keys = {
    { '<leader>e', ':NvimTreeToggle<CR>', desc = 'Toggle file explorer' },
  },
  config = function()
    -- disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,
      },
    })
  end,
}
