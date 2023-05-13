require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
})
-- TODO: move away from lsp-zero
local lsp = require("lsp-zero")
local luasnip = require("luasnip")
lsp.preset("recommended")
lsp.ensure_installed({ "tsserver", "lua_ls", "rust_analyzer" })
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
lsp.configure("ltex", {
	settings = {
		ltex = {
			disabledRules = {
				["en-US"] = {
					"UPPERCASE_SENTENCE_START",
				},
			},
		},
	},
})
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

-- luasnip
cmp_mappings["<Tab>"] = function(fallback)
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	else
		fallback()
	end
end
cmp_mappings["<S-Tab>"] = function(fallback)
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	else
		fallback()
	end
end

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	lsp.skip_server_setup({ "eslint" })

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.format_on_save({
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		["rust_analyzer"] = { "rust" },
		["gopls"] = { "go" },
		["astro"] = { "astro" },
		["null-ls"] = { "javascript", "typescript", "lua", "php" },
	},
})

lsp.setup()
vim.diagnostic.config({
	virtual_text = true,
})
