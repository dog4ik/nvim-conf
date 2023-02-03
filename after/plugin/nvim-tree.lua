local api = require("nvim-tree.api")
require("nvim-tree").setup({
  update_focused_file={enable=true},
  git={ignore=false}
})
vim.keymap.set("n", "<leader>tt", api.tree.toggle)

