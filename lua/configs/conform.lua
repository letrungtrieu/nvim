local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    go = { "goimports", "gofumpt" },
    -- Utilize official zig fmt via zigfmt for canonical source formatting
    zig = { "zigfmt" },
  },


  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
