-- LSP servers to start. Configs come from nvim-lspconfig (list of available servers:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md), local overrides from lsp/.
-- Keymaps are Neovim's defaults (K, grn, gra, grr, gri, grt, gO, Ctrl-s), see :h lsp-defaults.

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
