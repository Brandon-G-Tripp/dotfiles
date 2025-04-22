return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lspconfig = require('lspconfig')

      lspconfig.gopls.setup({
        capabilities = capabilities,
        cmd = { "gopls" },
        filetypes = { "go" },
        root_dir = require('lspconfig.util').root_pattern("go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = false,
          }
        },
        on_attach = function(client, bufnr)
          -- Set omnifunc
          vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Basic keymaps
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
          vim.keymap.set('i', '<C-x><C-o>', vim.lsp.omnifunc, { buffer = bufnr })
        end,
      })

      -- vim.lsp.config('lua_ls', {
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua or {}, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
              }
            }
          })
        end,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, { buffer = args.buf })

          if client:supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                -- Then ensure there's a final newline
                local bufnr = args.buf
                local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                local last_line = lines[#lines]

                if last_line and last_line ~= "" then
                  vim.api.nvim_buf_set_lines(bufnr, #lines, #lines, false, { "" })
                end
              end,
            })
          end
        end
      })
    end,

  }
}

