return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason.nvim",           -- Required for managing LSP servers
      "williamboman/mason-lspconfig.nvim", -- For automatically installing LSP servers
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lspconfig = require('lspconfig')
      local mason = require('mason')
      local mason_lspconfig = require('mason-lspconfig')

      mason.setup()
      mason_lspconfig.setup({ "pyright", "jedi-language-server", "typescript-language-server", "elixir-ls" })

      lspconfig.elixirls.setup({
        capabilities = capabilities,
        cmd = { vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/language_server.sh" },
        filetypes = { "elixir", "eelixir", "eex", "heex" },
        on_attach = function(client, bufnr)
          vim.bo[bufnr].omnifunc = 'v.lua.vim.lsp.omnifunc'
        end,
      })

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        init_options = { hostInfo = 'neovim' },
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        on_attach = function(client, bufnr)
          vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        end,
      })


      lspconfig.pyright.setup({
        capabilities = capabilities,
        filetypes = { "python" },
        root_dir = require('lspconfig.util').root_pattern("pyproject.toml", "setup.py", ".git"),
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",   -- Or "strict" for more rigorous checking
              diagnosticMode = "openFiles", -- Only show diagnostics for open files
              useLibraryCodeForTypes = true,
            },
          },
        },
        on_attach = function(client, bufnr)
          -- Set omnifunc for Python files
          vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        end,

      })

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
          -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
          -- vim.keymap.set('i', '<C-x><C-o>', vim.lsp.omnifunc, { buffer = bufnr })
        end,
      })

      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        callback = function()
          local client = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })[1]
          if client and client.supports_method('textDocument/formatting') then
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), id = client.id })
          end
          -- Your logic to ensure a final newline
          local bufnr = vim.api.nvim_get_current_buf()
          local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          local last_line = lines[#lines]
          if last_line and last_line ~= "" then
            vim.api.nvim_buf_set_lines(bufnr, #lines, #lines, false, { "" })
          end
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
          local opts = { buffer = args.bufnr, remap = false }
          if not client then return end

          vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
          vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
          vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
          vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
          vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
          vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)
          vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, { buffer = args.buf })
          vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
          vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

          if client:supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                -- Then ensure there's a final newline
                -- local bufnr = args.buf
                -- local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                -- local last_line = lines[#lines]

                -- if last_line and last_line ~= "" then
                --   vim.api.nvim_buf_set_lines(bufnr, #lines, #lines, false, { "" })
                -- end
              end,
            })
          end
        end
      })
    end,

  }
}
