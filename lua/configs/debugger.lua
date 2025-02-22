local dap = require("dap")
local ui = require("dapui")

dap.adapters.rust_gdb = {
  type = "executable",
  command = "rust-gdb",
  args = { "-i", "dap" }
}

dap.configurations.rust = {
  {
    name = "Launch",
    type = "rust_gdb",
    request = "launch",
    program = function()
      return vim.fn.input("Path: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  }
}

require("dapui").setup()
require("nvim-dap-virtual-text").setup({})
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
vim.keymap.set("n", "<leader>?", function()
  require("dapui").eval(nil, { enter = true })
end)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dn", dap.step_into)
vim.keymap.set("n", "<leader>dN", dap.step_over)
vim.keymap.set("n", "<leader>dP", dap.step_out)
vim.keymap.set("n", "<leader>dp", dap.step_back)
vim.keymap.set("n", "<leader>dr", dap.restart)

dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end
