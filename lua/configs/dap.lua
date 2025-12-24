local dap = require "dap"

-- Rust debugging configuration
dap.configurations.rust = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    showDisassembly = "never",
  },
  {
    name = "Launch with arguments",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    args = function()
      local input = vim.fn.input("Arguments: ")
      return vim.split(input, " +")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    showDisassembly = "never",
  },
  {
    name = "Attach to process (PID)",
    type = "codelldb",
    request = "attach",
    pid = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}
