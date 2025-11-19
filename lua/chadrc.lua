-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "vscode_dark",
  hl_override = {
    -- Comment: xanh nhạt hơn, italic giống VSCode Modern
    Comment = { fg = "#6A9955", italic = true },
    ["@comment"] = { fg = "#6A9955", italic = true },

    -- Keyword: tím VSCode Modern
    Keyword = { fg = "#C586C0" },
    ["@keyword"] = { fg = "#C586C0" },

    -- String: vàng sáng
    String = { fg = "#CE9178" },
    ["@string"] = { fg = "#CE9178" },

    -- Function: xanh cyan
    Function = { fg = "#c7c79b" },
    ["@function"] = { fg = "#c7c79b" },

    -- Variable (default white)
    Identifier = { fg = "#D4D4D4" },
    ["@variable"] = { fg = "#D4D4D4" },

    -- Type: xanh nước biển nhẹ
    Type = { fg = "#4EC9B0" },
    ["@type"] = { fg = "#4EC9B0" },

    -- Boolean, number: cam
    ["@number"] = { fg = "#B5CEA8" },
    ["@boolean"] = { fg = "#569CD6" },

    -- Operator: xanh dương
    Operator = { fg = "#D4D4D4" },
    ["@operator"] = { fg = "#D4D4D4" },

    -- Background màu VSCode Modern
    Normal = { bg = "#1E1E1E" },
    NormalFloat = { bg = "#252526" },
    FloatBorder = { fg = "#3C3C3C", bg = "#252526" },
  },
}

M.ui = {
  nvtree = {
    view = {
      side = "left",
      width = 25,
    },
    filters = {
      dotfiles = false,
      custom = { ".git", "node_modules" },
    },
    git = {
      enable = true,
      ignore = true,
    },
  },
}

-- M.nvdash = { load_on_startup = true }

return M
