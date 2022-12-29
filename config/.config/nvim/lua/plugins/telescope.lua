local builtin = require('telescope.builtin')

-- run git_files. if there's a .git.
-- If it's not available, use find_files instead.
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
function project_files()
  local opts = {}
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require"telescope.builtin".git_files(opts)
  else
    require"telescope.builtin".find_files(opts)
  end
end

-- https://zenn.dev/kawarimidoll/articles/36b1cc92d00453
vim.api.nvim_create_user_command(
    'NvimConfig',
    function (opts)
        vim.cmd(":Telescope find_files search_dirs=~/.config/nvim/")
    end,
    {
        nargs = 0
    }
)
vim.api.nvim_create_user_command(
    'OldFiles',
    function (opts)
        builtin.oldfiles({
            path_display = {"shorten"}
        })
    end,
    {
        nargs = 0
    }
)

vim.keymap.set('n', '<C-p>', project_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fn', ":Telescope find_files search_dirs=~/.config/nvim/", {})

