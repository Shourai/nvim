--- All available lsp serverss: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

vim.lsp.enable({
  "pyright",
  "ruff",
  "lua_ls",
  "yamlls",
  "ts_ls"
})

vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })
