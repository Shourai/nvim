--- All available lsp serverss: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

vim.lsp.enable({
  "pyright",
  "ruff",
  "lua_ls",
  "yamlls",
  "ts_ls"
})

-- Commented out diagnostic config for the tiny-inline-diagnostic.nvim plugin
-- vim.diagnostic.config({ virtual_lines = { current_line = false }, virtual_text = false })
