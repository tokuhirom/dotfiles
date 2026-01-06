return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('Comment').setup({
      -- Add custom keybindings
      toggler = {
        line = 'gcc',  -- Line-comment toggle
        block = 'gbc', -- Block-comment toggle
      },
      opleader = {
        line = 'gc',   -- Line-comment operator
        block = 'gb',  -- Block-comment operator
      },
      extra = {
        above = 'gcO', -- Add comment on the line above
        below = 'gco', -- Add comment on the line below
        eol = 'gcA',   -- Add comment at the end of line
      },
    })

    -- ideavim compatible: ,/ for line comment toggle
    vim.keymap.set('n', '<leader>/', function()
      return vim.api.nvim_get_vvar('count') == 0
        and '<Plug>(comment_toggle_linewise_current)'
        or '<Plug>(comment_toggle_linewise_count)'
    end, { expr = true, desc = 'Comment toggle current line' })

    -- Visual mode ,/ for comment toggle
    vim.keymap.set('x', '<leader>/', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Comment toggle linewise (visual)' })
  end,
}
