-- ===============================
-- vscode-init.lua (Windows)
-- Dùng cho VSCode Neovim
-- ===============================

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
