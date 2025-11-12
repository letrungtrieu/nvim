return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    respect_buf_cwd = true,
    update_cwd = true,

    renderer = {
      indent_markers = { enable = true },
      icons = {
        show = {
          file = true,
          folder = true,
          git = true,
        },
      },
    },

    filters = {
      dotfiles = false,
      custom = { ".git", "node_modules", ".cache" },
    },

    actions = {
      open_file = {
        quit_on_open = false,
      },
    },
  },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
  },
}
