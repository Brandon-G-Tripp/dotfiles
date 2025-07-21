local lspconfig = require('lspconfig')
local status, lsp = pcall(require, 'lsp-zero')
if not status then
	print("lsp-zero not found!")
	return
end

lsp.preset("recommended")

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
end)


-- Configure mason to install LSP servers
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		'rust_analyzer',
		'clangd',
		'lua_ls',
		'dockerls',
		'elixirls',
		'gopls',
		'graphql',
		'sqlls',
		'templ',
	},
	handlers = {
		lsp.default_setup,
		lua_ls = function()
			-- configure lua language server for neovim
			local lua_opts = lsp.nvim_lua_ls()
			lspconfig.lua_ls.setup(lua_opts)
		end,
	},
})

-- Fix Undefined global 'vim'
lspconfig.lua_ls.setup(lsp.nvim_lua_ls({
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
}))


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = {
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
}

local cmp_sources = {
	{ name = 'path' },
	{ name = 'nvim_lsp' },
	{ name = 'nvim_lua' },
	{ name = 'buffer',  keyword_length = 3 },
	{ name = 'luasnip', keyword_length = 2 },
}

-- Disable tab since you're not using it
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

cmp.setup({
	mapping = cmp_mappings
})

lsp.setup()

-- IOriginal config below with packer
-- local lsp = require("lsp-zero")

-- lsp.preset("recommended")

-- lsp.ensure_installed({
-- 	'rust_analyzer',
-- 	'clangd',
--     'lua_ls',
-- 	'dockerls',
--     'tsserver',
-- 	'elixirls',
-- 	'gopls',
-- 	'graphql',
-- 	'sqlls',
-- 	'lua_ls',
--     'templ',
-- })

-- -- Fix Undefined global 'vim'
-- lsp.configure('lua_ls', {
--     settings = {
--         Lua = {
--             diagnostics = {
--                 globals = { 'vim' }
--             }
--         }
--     }
-- })

-- -- lsp.configure('templ', {
-- --     filetypes = { "templ" },
-- -- })
-- --
-- -- lsp.configure('tsserver', {
-- --     settings = {
-- --         javascript = {
-- --             format = {
-- --                 enable = true
-- --             }
-- --         }
-- --     },
-- --     filetypes = { "javascript", "typescript", "templ", "gohtml" } -- Add templ support
-- -- })



-- local cmp = require('cmp')
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--   ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--   ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--   ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--   ["<C-Space>"] = cmp.mapping.complete(),
-- })

-- -- Ensure cmp works with templ files
-- -- cmp.setup.filetype({'templ', 'gohtml'}, {
-- --     sources = cmp.config.sources({
-- --         { name = 'nvim_lsp' },
-- --         { name = 'buffer' },
-- --         { name = 'path' }
-- --     })
-- -- })
-- --
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

-- lsp.setup_nvim_cmp({
--   mapping = cmp_mappings
-- })

-- lsp.set_preferences({
--     suggest_lsp_servers = false,
--     -- sign_icons = {
--     --     error = 'E',
--     --     warn = 'W',
--     --     hint = 'H',
--     --     info = 'I'
--     -- }
-- })

-- lsp.on_attach(function(client, bufnr)
--   local opts = {buffer = bufnr, remap = false}

--   vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--   vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--   vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--   vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--   vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--   vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--   vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--   vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--   vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--   -- vim.keymap.set("i", "<C-hh>", function() vim.lsp.buf.signature_help() end, opts)
-- end)




-- lsp.setup()

-- -- vim.diagnostic.config({
-- --     virtual_text = true
-- -- })

