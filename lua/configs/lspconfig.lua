local nvchad_lsp_defaults = require "nvchad.configs.lspconfig"
nvchad_lsp_defaults.defaults()

-- Suppress default virtual text so tiny-inline-diagnostic handles inline rendering cleanly
vim.diagnostic.config { virtual_text = false }


-- Pre-load nvim-lspconfig so vim.lsp.config is populated with default server schemas in Neovim 0.11+
require "lspconfig"

-- Custom configuration for Zig Language Server (ZLS)
vim.lsp.config("zls", {
  cmd = { "zls" },
  filetypes = { "zig", "zir" },
  root_markers = { "zls.json", "build.zig", ".git" },
  settings = {
    zls = {
      -- Expose parameter types and deduced types inline in the editor buffer
      enable_inlay_hints = true,
      inlay_hints_show_builtin = true,
      inlay_hints_exclude_single_argument = true,
      inlay_hints_hide_redundant_param_names = true,
      inlay_hints_hide_redundant_param_names_matching_var_name = true,
      -- Provide language server snippet completions during coding
      enable_snippets = true,
      -- Surface compile-time error fixes and idiomatic Zig naming warnings
      enable_autofix = true,
      warn_style = true,
      highlight_global_var_declarations = true,
    },
  },
})

-- Automatically activate Neovim inlay hints when a language server with inlay support attaches
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Automatically activate inlay hints when supported by attached LSP server",
  callback = function(lsp_attach_event)
    local active_lsp_client = vim.lsp.get_client_by_id(lsp_attach_event.data.client_id)
    -- Verify that client explicitly advertises inlay hints capability before enabling
    if active_lsp_client and active_lsp_client:supports_method "textDocument/inlayHint" then
      vim.lsp.inlay_hint.enable(true, { bufnr = lsp_attach_event.buf })
    end
  end,
})

-- Register and activate required language servers: gopls for Go, zls for Zig
local configured_language_servers = { "gopls", "zls" }
vim.lsp.enable(configured_language_servers)

