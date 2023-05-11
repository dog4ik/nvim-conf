require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"vimdoc",
		"javascript",
		"typescript",
		"lua",
		"rust",
		"tsx",
		"json",
		"css",
		"html",
		"astro",
		"prisma",
		"go",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = false,
	autotag = {
		enable = true,
	},
	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		additional_vim_regex_highlighting = false,
	},
})
