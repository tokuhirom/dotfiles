return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'folke/neodev.nvim',
    },
    config = function()
      -- LSP サーバーは mason ではなく外部 (mise / brew / rustup / npm など) で
      -- インストールする (ADR-0022)。PATH 上に実体があるものだけを有効化する。
      local servers = {
        lua_ls = 'lua-language-server',
        ts_ls = 'typescript-language-server',
        pyright = 'pyright-langserver',
        rust_analyzer = 'rust-analyzer',
        gopls = 'gopls',
      }
      for name, bin in pairs(servers) do
        if vim.fn.executable(bin) == 1 then
          vim.lsp.enable(name)
        end
      end

      -- Setup LspAttach autocmd for keybindings
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion
          vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })

          local opts = { buffer = ev.buf, noremap = true, silent = true }

          vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, opts)  -- go to definition
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end,
  },
}
