require("rose-pine").setup({
	--- @usage 'main' | 'moon' | 'dawn'
	dark_variant = "moon",
  dim_inactive_windows = false,
  extend_background_behind_borders = true,
  styles = {
    transparency = true,
    bold = true,
  },
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
require("lackluster").setup({
  tweak_background = {
    normal = 'none',
    telescope = 'none',
    menu = 'none',
    popup = 'none',
  },
})

function MyColors(color)
	color = color
  or "rose-pine"
  or "lackluster-hack"
  or "catppuccin"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

MyColors()
