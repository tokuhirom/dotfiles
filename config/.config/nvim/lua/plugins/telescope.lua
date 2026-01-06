return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = 'Telescope',
  keys = {
    { '<C-p>', function()
      -- Use find_files with gitignore respect
      -- Shows untracked files, dotfiles, hides gitignored files, doesn't show git-deleted files
      require"telescope.builtin".find_files({
        hidden = true,
        no_ignore = false,
        follow = true,
      })
    end, desc = 'Find files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
    { '<leader>fn', '<cmd>Telescope find_files search_dirs=~/.config/nvim/<cr>', desc = 'Nvim config files' },
  },
  config = function()
    local builtin = require('telescope.builtin')

    -- User commands
    vim.api.nvim_create_user_command(
      'NvimConfig',
      function()
        vim.cmd(":Telescope find_files search_dirs=~/.config/nvim/")
      end,
      { nargs = 0 }
    )

    vim.api.nvim_create_user_command(
      'OldFiles',
      function()
        builtin.oldfiles({
          path_display = {"shorten"}
        })
      end,
      { nargs = 0 }
    )
  end,
}
