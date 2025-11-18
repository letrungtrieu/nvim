-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "vscode_dark",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
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
