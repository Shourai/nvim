return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      -- lsp
      "lua_ls",
      "pyright",
      "ruff",
      "ts_ls",
      "yamlls",
    },
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
  },
}
