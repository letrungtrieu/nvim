-- ===============================
-- vscode-init.lua (Windows)
-- Dùng cho VSCode Neovim
-- ===============================
-- VSCode
local vs = require("vscode-neovim")

-- Basic safe settings
vim.opt.number = true
vim.opt.termguicolors = true
vim.g.mapleader = " "

-- Lazy bootstrap
local lazypath = vim.fn.expand("~\\AppData\\Local\\nvim-data\\lazy\\lazy.nvim")
if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
end
vim.opt.rtp:prepend(lazypath)

-- Load ONLY plugin safe for VSCode
require("lazy").setup({
  -- Surround
  { "kylechui/nvim-surround", opts = {} },

  -- Autopairs
  { "windwp/nvim-autopairs", opts = {} },

  -- Comment toggling
  { "numToStr/Comment.nvim", opts = {} },

  -- Git signs (works well with VSCode)
  { "lewis6991/gitsigns.nvim", opts = {} },

  -- Treesitter (safe)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
    },
  },

  -- Flash / Motion
  { "folke/flash.nvim", opts = {} },

  -- Which key
  { "folke/which-key.nvim", opts = {} },
  
  -- Multi Cursors
  {
    'vscode-neovim/vscode-multi-cursor.nvim',
    event = 'VeryLazy',
    cond = not not vim.g.vscode,
    opts = {},
  },
  
})

-- Key Map
-- Clear search highlight with ESC
vim.keymap.set("n", "<Esc>", function()
  vim.cmd("nohlsearch")
  -- Trả ESC về VSCode để còn dùng các tính năng khác
  require("vscode-neovim").call("cursorMove", { to = "viewPortTop", by = "line" })
end, { silent = true })

-- Fast Key Esc
vim.keymap.set("i", "jk", "<Esc>")

-- Jumps
-- Back
vim.keymap.set("n", "mh", function()
  vs.call("workbench.action.navigateBack")
end, { silent = true })

-- Forward
vim.keymap.set("n", "ml", function()
  vs.call("workbench.action.navigateForward")
end, { silent = true })

-- Disable Vim's own C-o / C-i (optional)
vim.keymap.set("n", "<C-o>", "<Nop>")
vim.keymap.set("n", "<C-i>", "<Nop>")
