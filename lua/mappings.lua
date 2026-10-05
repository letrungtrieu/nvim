require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd>wa<cr>")

map({ "t" }, "<C-x>", "<C-\\><C-n> <cmd>bdelete!<cr>")

-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
  "n",
  "<Leader>dd",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })

-- jump when use snip
map("i", "<Tab>", function()
  return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
end, { expr = true })
map("i", "<S-Tab>", function()
  return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
end, { expr = true })

-- show diagnostic
local function split(str)
  local result = {}
  for line in str:gmatch "([^\n]+)" do
    table.insert(result, line)
  end
  return result
end

local function diagnostic()
  local buf = vim.api.nvim_create_buf(false, true)
  local diagnostics = vim.diagnostic.get(0)
  local lines = {}

  for _, d in ipairs(diagnostics) do
    local prefix = (d.lnum + 1) .. ": "
    local msg_lines = split(d.message)
    msg_lines[1] = prefix .. msg_lines[1]
    vim.list_extend(lines, msg_lines)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.api.nvim_open_win(buf, true, {
    relative = "cursor",
    width = 60,
    height = #lines,
    col = 1,
    row = 1,
    border = "rounded",
    style = "minial",
  })
end

map("n", "<Leader>kk", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<Leader>kl", vim.diagnostic.setqflist, { desc = "Show list diagnostics" })

-- Quick fix
map("n", "<Leader>cf", vim.lsp.buf.code_action, { desc = "Quick fix" })

-- Inlay hints toggle for languages with rich type annotations like Zig and Rust
map("n", "<Leader>th", function()
  local current_active_buffer = vim.api.nvim_get_current_buf()
  local is_inlay_hint_currently_enabled = vim.lsp.inlay_hint.is_enabled { bufnr = current_active_buffer }
  -- Invert the current inlay hint state specifically for the active buffer
  vim.lsp.inlay_hint.enable(not is_inlay_hint_currently_enabled, { bufnr = current_active_buffer })
end, { desc = "Toggle LSP inlay hints" })

-- Toggle inline diagnostics overlay (tiny-inline-diagnostic)
map("n", "<Leader>td", function()
  -- Toggle inline diagnostic display dynamically
  require("tiny-inline-diagnostic").toggle()
end, { desc = "Toggle inline diagnostics" })



