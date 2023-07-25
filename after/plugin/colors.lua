require("rose-pine").setup({
	--- @usage 'main' | 'moon'
	dark_variant = "moon",
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = true,
	disable_float_background = false,
	disable_italics = true,
})
require("onedark").setup({
	style = "cool",
	transparent = true,
})
require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	transparent_background = true,
	no_italic = true, -- Force no italic
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		telescope = true,
		harpoon = true,
		mason = true,
		treesitter = true,
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})

function MyColors(color)
	color = color or "catppuccin" or "onedark" or "rose-pine" or "tokyonight-night"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

MyColors()
