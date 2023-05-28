local api = require("nvim-tree.api")
require("nvim-tree").setup({
	update_focused_file = { enable = true },
	git = { ignore = false },
	filters = {
		custom = { "^\\.git$", "node_modules" },
	},
	hijack_netrw = false,
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})

vim.keymap.set("n", "<leader>tt", api.tree.toggle)
