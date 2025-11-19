--- All available lsp serverss: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

vim.lsp.enable({
  "ansiblels",
  "lua_ls",
  "marksman",
  "pyright",
  "ruff",
  "terraformls",
  "tflint",
  "ts_ls",
  "yamlls",
})

-- Commented out diagnostic config for the tiny-inline-diagnostic.nvim plugin
-- vim.diagnostic.config({ virtual_lines = { current_line = false }, virtual_text = false })
