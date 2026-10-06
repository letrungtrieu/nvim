require "nvchad.autocmds"

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent! w")
    end
  end
})

-- Automatically recompile and reload Base46 highlight cache whenever chadrc is saved
-- Base46 stores precompiled Lua bytecode in stdpath('data')/base46; without recompilation,
-- changes made directly to chadrc.lua are ignored until an explicit reload occurs.
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*/lua/chadrc.lua",
  callback = function()
    -- Re-execute Base46 compilation to regenerate cache files and immediately update active highlights
    require("base46").load_all_highlights()
    -- Refresh open buffers so Treesitter and syntax highlighters re-evaluate applied styles
    vim.cmd("redraw!")
  end,
})

