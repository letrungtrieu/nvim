local dap_client = require "dap"

-- Determine platform-specific file separators and executable names
local is_windows_os = vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1
local file_path_separator = is_windows_os and "\\" or "/"

-- Resolve codelldb adapter path from Mason package installation or system PATH
local mason_data_directory = vim.fn.stdpath "data" .. file_path_separator .. "mason"
local codelldb_mason_package = mason_data_directory
  .. file_path_separator
  .. "packages"
  .. file_path_separator
  .. "codelldb"
  .. file_path_separator
  .. "extension"
  .. file_path_separator
  .. "adapter"
  .. file_path_separator
  .. (is_windows_os and "codelldb.exe" or "codelldb")

-- Fall back to system-wide binary if Mason has not yet downloaded codelldb
local codelldb_executable_path = vim.fn.filereadable(codelldb_mason_package) == 1
    and codelldb_mason_package
  or "codelldb"

-- Configure codelldb server adapter for LLDB-based compiled language debugging
dap_client.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_executable_path,
    args = { "--port", "${port}" },
  },
}

-- Configure native GDB adapter as a reliable zero-install debugger on Linux
dap_client.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

-- Rust debugging configuration
dap_client.configurations.rust = {
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
      local user_arguments_input = vim.fn.input "Arguments: "
      return vim.split(user_arguments_input, " +")
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

-- Zig debugging configuration: provides both codelldb and GDB debugging options
dap_client.configurations.zig = {
  {
    -- Launch compiled Zig binary via codelldb, defaulting search path to zig-out/bin
    name = "Launch Zig binary (codelldb)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/zig-out/bin/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    showDisassembly = "never",
  },
  {
    -- Launch Zig binary with interactive CLI arguments via codelldb
    name = "Launch Zig binary with args (codelldb)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/zig-out/bin/", "file")
    end,
    args = function()
      local user_arguments_input = vim.fn.input "Arguments: "
      return vim.split(user_arguments_input, " +")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    showDisassembly = "never",
  },
  {
    -- Fallback to system GDB which requires no external adapter installation
    name = "Launch Zig binary (GDB)",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/zig-out/bin/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    -- Attach to an already running Zig process by selecting its PID
    name = "Attach to process (PID - codelldb)",
    type = "codelldb",
    request = "attach",
    pid = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}
