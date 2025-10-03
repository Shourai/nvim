vim.lsp.enable({
  "pyright",
  "ruff",
  "lua_ls",
})
vim.diagnostic.config({ virtual_lines = {current_line = true}, virtual_text = false })
