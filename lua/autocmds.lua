require "nvchad.autocmds"

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent! w")
    end
  end
})
