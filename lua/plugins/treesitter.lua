return {
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	"windwp/nvim-ts-autotag",
}
