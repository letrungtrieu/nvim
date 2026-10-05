vim.uv = vim.uv or vim.loop
vim.fs = vim.fs or {}
vim.fs.joinpath = vim.fs.joinpath or function(...)
  return table.concat({...}, "/"):gsub("//+", "/")
end
-- Newer nvim-treesitter revisions require vim.list.unique which is native only in Nvim 0.12+.
-- We polyfill it here to preserve parser normalization and installation in Nvim 0.11.
vim.list = vim.list or {}
vim.list.unique = vim.list.unique or function(target_element_list)
  -- Sort elements first because vim.fn.uniq only removes adjacent identical items
  table.sort(target_element_list)
  return vim.fn.uniq(target_element_list)
end
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"

vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
