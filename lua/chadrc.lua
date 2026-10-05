-- Configuration file adhering to NvChad v2.5 structure
-- Base46 handles theming, highlight caching, and UI integrations
---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "vscode_dark",
  hl_override = {
    -- Comments: VS Code italic green
    Comment = { fg = "#6A9955", italic = true },
    ["@comment"] = { fg = "#6A9955", italic = true },

    -- Keywords: Declaration keywords in VS Code blue, control flow in VS Code purple
    Keyword = { fg = "#569CD6" },
    ["@keyword"] = { fg = "#569CD6" },
    ["@keyword.function"] = { fg = "#569CD6" },
    ["@keyword.modifier"] = { fg = "#569CD6" },
    ["@keyword.type"] = { fg = "#569CD6" },
    -- Base46 @keyword.import links to Include; override both to keyword purple
    Include = { fg = "#C586C0" },
    ["@keyword.import"] = { fg = "#C586C0" },
    ["@keyword.return"] = { fg = "#C586C0" },
    ["@keyword.repeat"] = { fg = "#C586C0" },
    ["@keyword.conditional"] = { fg = "#C586C0" },
    ["@keyword.exception"] = { fg = "#C586C0" },

    -- Strings: Standard VS Code brownish orange
    String = { fg = "#CE9178" },
    ["@string"] = { fg = "#CE9178" },

    -- Functions and methods: Standard VS Code yellowish cream (#DCDCAA)
    Function = { fg = "#DCDCAA" },
    ["@function"] = { fg = "#DCDCAA" },
    ["@function.call"] = { fg = "#DCDCAA" },
    -- In Zig, built-in identifiers like @import, @as, @intCast are colored purple
    ["@function.builtin"] = { fg = "#C586C0" },
    ["@function.method"] = { fg = "#DCDCAA" },
    ["@function.method.call"] = { fg = "#DCDCAA" },

    -- Variables, members, and parameters: Standard VS Code light blue (#9CDCFE)
    Identifier = { fg = "#9CDCFE" },
    ["@variable"] = { fg = "#9CDCFE" },
    ["@variable.builtin"] = { fg = "#569CD6" },
    ["@variable.member"] = { fg = "#9CDCFE" },
    ["@variable.member.key"] = { fg = "#9CDCFE" },
    ["@variable.parameter"] = { fg = "#9CDCFE" },
    ["@property"] = { fg = "#9CDCFE" },
    -- Modules/packages like std, builtin use VS Code class/type teal (#4EC9B0)
    ["@module"] = { fg = "#4EC9B0" },
    ["@module.builtin"] = { fg = "#4EC9B0" },

    -- Macro calls: Yellowish cream like standard functions
    ["@function.macro"] = { fg = "#DCDCAA" },
    ["@constant.macro"] = { fg = "#4FC1FF" },

    -- Types: Standard VS Code turquoise / teal (#4EC9B0)
    Type = { fg = "#4EC9B0" },
    ["@type.builtin"] = { fg = "#4EC9B0" },

    -- Numbers and booleans: VS Code olive and blue
    ["@number"] = { fg = "#B5CEA8" },
    Boolean = { fg = "#569CD6" },

    -- Operators and delimiters: Neutral light grey
    Operator = { fg = "#D4D4D4" },
    ["@operator"] = { fg = "#D4D4D4" },
    ["@punctuation.delimiter"] = { fg = "#D4D4D4" },
    ["@punctuation.bracket"] = { fg = "#D4D4D4" },

    -- Editor background: Clean VS Code dark canvas
    Normal = { bg = "#1E1E1E" },
    NormalFloat = { bg = "#252526" },
    FloatBorder = { fg = "#3C3C3C", bg = "#252526" },

    -- Constants and enum values: VS Code cyan / light blue (#4FC1FF)
    Constant = { fg = "#4FC1FF" },
    ["@constant"] = { fg = "#4FC1FF" },
    ["@constant.builtin"] = { fg = "#569CD6" },

    -- LSP Semantic Token overrides: Avoid harsh defaults from Base46 base08
    ["@lsp.type.namespace"] = { fg = "#4EC9B0" },
    ["@lsp.type.property"] = { fg = "#9CDCFE" },
    ["@lsp.type.parameter"] = { fg = "#9CDCFE" },
    ["@lsp.type.variable"] = { fg = "#9CDCFE" },
    ["@lsp.type.struct"] = { fg = "#4EC9B0" },
    ["@lsp.type.class"] = { fg = "#4EC9B0" },
    ["@lsp.type.enum"] = { fg = "#4EC9B0" },
    ["@lsp.type.interface"] = { fg = "#4EC9B0" },
    ["@lsp.type.typeAlias"] = { fg = "#4EC9B0" },
    ["@lsp.type.builtinType"] = { fg = "#4EC9B0" },
    ["@lsp.type.function"] = { fg = "#DCDCAA" },
    ["@lsp.type.method"] = { fg = "#DCDCAA" },
    ["@lsp.type.macro"] = { fg = "#C586C0" },
    ["@lsp.type.enumMember"] = { fg = "#4FC1FF" },
    ["@lsp.type.const"] = { fg = "#4FC1FF" },
    ["@lsp.type.keyword"] = { fg = "#C586C0" },
    ["@lsp.type.string"] = { fg = "#CE9178" },
    ["@lsp.type.number"] = { fg = "#B5CEA8" },
    ["@lsp.type.boolean"] = { fg = "#569CD6" },
  },
  -- Register highlight captures absent from default Base46 integration tables
  -- Base46 compiles hl_add into the defaults cache so they persist across sessions
  hl_add = {
    ["@type"] = { fg = "#4EC9B0" },
    ["@boolean"] = { fg = "#569CD6" },
    -- Ensure LSP semantic tokens are saved in defaults cache
    ["@lsp.type.namespace"] = { fg = "#4EC9B0" },
    ["@lsp.type.class"] = { fg = "#4EC9B0" },
    ["@lsp.type.struct"] = { fg = "#4EC9B0" },
    ["@lsp.type.type"] = { fg = "#4EC9B0" },
    ["@lsp.type.macro"] = { fg = "#C586C0" },
    ["@lsp.type.keyword"] = { fg = "#C586C0" },
  },
}

return M
