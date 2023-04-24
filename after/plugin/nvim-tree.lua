local api = require("nvim-tree.api")
require("nvim-tree").setup({
  update_focused_file={enable=true},
  git={ignore=false},
  filters={
    custom={ '^\\.git$', 'node_modules' }
  }
})

local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
vim.keymap.set("n", "<leader>tt", api.tree.toggle)

