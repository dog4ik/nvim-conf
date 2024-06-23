require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
})
-- TODO: move away from lsp-zero
local lsp = require("lsp-zero")
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'rust_analyzer'},
  handlers = {
    lsp.default_setup,
  },
})
lsp.preset("recommended")
lsp.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
lsp.configure("yamlls", {
	settings = {
		yaml = {
			keyOrdering = false,
		},
	},
})
lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d",
    function() vim.diagnostic.goto_prev({ severity = vim.lsp.protocol.DiagnosticSeverity.Error }) end, opts)
  vim.keymap.set("n", "]d",
    function() vim.diagnostic.goto_next({ severity = vim.lsp.protocol.DiagnosticSeverity.Error }) end, opts)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

-- lsp.format_on_save({
-- 	format_opts = {
-- 		async = false,
-- 		timeout_ms = 10000,
-- 	},
-- 	servers = {
-- 		["rust_analyzer"] = { "rust" },
-- 		["gopls"] = { "go" },
-- 		["astro"] = { "astro" },
-- 		["prismals"] = { "prisma" },
-- 		["null-ls"] = { "javascript", "typescript", "typescriptreact", "lua", "php", "markdown", "json", "css", "html" },
-- 	},
-- })

lsp.setup()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		-- { name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},

	mapping = cmp_mappings,
})

vim.diagnostic.config({
	virtual_text = true,
  signs = false,
})

local dog4ik_group = vim.api.nvim_create_augroup("dog4ik", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufLeave", {
	group = dog4ik_group,
	pattern = "*",
	callback = function()
		vim.cmd(":wall")
	end,
})
