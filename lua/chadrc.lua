-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "vscode_dark",
  hl_override = {
    -- Comment
    Comment = { fg = "#6A9955", italic = true },
    ["@comment"] = { fg = "#6A9955", italic = true },

    -- Keyword
    Keyword = { fg = "#C586C0" },
    ["@keyword"] = { fg = "#C586C0" },

    -- String
    String = { fg = "#CE9178" },
    ["@string"] = { fg = "#CE9178" },

    -- Function
    Function = { fg = "#C7C79B" },
    ["@function"] = { fg = "#C7C79B" },

    -- Variable
    Identifier = { fg = "#9CDCFE" },
    ["@variable"] = { fg = "#9CDCFE" },

    -- Type
    Type = { fg = "#4EC9B0" },
    ["@type"] = { fg = "#4EC9B0" },

    -- Boolean, number
    ["@number"] = { fg = "#B5CEA8" },
    ["@boolean"] = { fg = "#569CD6" },

    -- Operator
    Operator = { fg = "#D4D4D4" },
    ["@operator"] = { fg = "#D4D4D4" },

    -- Background
    Normal = { bg = "#1E1E1E" },
    NormalFloat = { bg = "#252526" },
    FloatBorder = { fg = "#3C3C3C", bg = "#252526" },

    -- Constant
    Constant = { fg = "#D16969" },
    ["@constant"] = { fg = "#D16969" },

    -- Parameter
    Parameter = { fg = "#9CDCFE" },
    ["@parameter"] = { fg = "#9CDCFE" },

    -- Property
    Property = { fg = "#9CDCFE" },
    ["@property"] = { fg = "#9CDCFE" },
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
