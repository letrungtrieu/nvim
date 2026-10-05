return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "mrcjkb/rustaceanvim",

    version = "^6", -- Recommended

    lazy = false, -- This plugin is already lazy

    ft = "rust",

    config = function()
      local is_windows = vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1
      local sep = is_windows and "\\" or "/"

      local mason_path = vim.fn.stdpath "data" .. sep .. "mason"
      local codelldb_pkg = mason_path .. sep .. "packages" .. sep .. "codelldb"
      local extension_path = codelldb_pkg .. sep .. "extension" .. sep

      local codelldb_path, liblldb_path

      if is_windows then
        codelldb_path = extension_path .. "adapter" .. sep .. "codelldb.exe"
        liblldb_path = extension_path .. "lldb" .. sep .. "bin" .. sep .. "liblldb.dll"
      else
        codelldb_path = extension_path .. "adapter" .. sep .. "codelldb"
        liblldb_path = extension_path .. "lldb" .. sep .. "lib" .. sep .. "liblldb.so"
      end

      local cfg = require "rustaceanvim.config"

      vim.g.rustaceanvim = {

        dap = {

          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    -- Official Zig plugin providing syntax, filetype detection, and compiler commands
    "ziglang/zig.vim",
    ft = "zig",
    init = function()
      -- Disable built-in format on save so conform.nvim maintains exclusive control over formatting
      vim.g.zig_fmt_autosave = 0
    end,
  },

  {
    -- Treesitter grammar integration for syntax highlighting and AST queries
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, default_treesitter_options)
      -- Guarantee that the zig parser is included with the default NvChad parsers
      if not vim.tbl_contains(default_treesitter_options.ensure_installed, "zig") then
        table.insert(default_treesitter_options.ensure_installed, "zig")
      end
      return default_treesitter_options
    end,
  },


  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      require "configs.dap"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup {}
      require("cmp").setup.buffer {
        sources = { { name = "crates" } },
      }
    end,
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function()
    end,
  },
  {
    "folke/flash.nvim",
    init = function()
      require("flash").setup()
    end,
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function()
      require("dap-go").setup()  -- Setup tự động adapter và configs cơ bản
    end,
    ft = "go",
    opts = {  -- Custom options cho plugin
      delve = {
        path = "dlv",  -- Đường dẫn dlv (mặc định PATH)
        initialize_timeout_sec = 20,  -- Timeout init session
        port = "${port}",  -- Port ngẫu nhiên
        build_flags = { "-tags", "integration" },  -- Flags build tùy chỉnh nếu cần
      },
      dap_configurations = {  -- Thêm configs custom (sẽ merge vào dap.configurations.go)
        {
          type = "go",
          name = "Debug current file",
          request = "launch",
          program = "${file}",
        },
      },
      -- Tích hợp dap-ui tự động
      dapui = true,
    },
  },
  -- Các deps khác nếu cần
  { "theHamsta/nvim-dap-virtual-text", config = true },

  {
    -- Elegant inline diagnostic overlay with curved connectors under the cursor
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      preset = "modern",
      options = {
        -- Display source language server name (e.g. zls, gopls, lua_ls)
        show_source = {
          enabled = true,
        },
        -- Support displaying multi-line error explanations clearly
        multilines = {
          enabled = true,
          always_show = true,
        },
      },
    },
    config = function(_, configured_plugin_options)
      require("tiny-inline-diagnostic").setup(configured_plugin_options)
      -- Suppress built-in virtual_text to avoid duplicated diagnostic labels
      vim.diagnostic.config { virtual_text = false }
    end,
  },
}

