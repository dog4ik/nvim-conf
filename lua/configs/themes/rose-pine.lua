require("rose-pine").setup({
	--- @usage 'main' | 'moon' | 'dawn'
	dark_variant = "moon",
  dim_inactive_windows = false,
  extend_background_behind_borders = true,
  styles = {
    transparency = true,
    bold = true,
    italic = false,
  },
})

vim.cmd([[colorscheme rose-pine]])
