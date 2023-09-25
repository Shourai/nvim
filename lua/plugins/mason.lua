return {
  {"williamboman/mason.nvim",
    config  = function()
      require("mason").setup()
    end
  },
  {"williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ansiblels", "bashls", "dockerls",
          "gopls", "html", "tsserver", "marksman", "pyright" }
      })
    end},
  {"jayp0521/mason-null-ls.nvim",
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "stylua", "jq", "prettier", "eslint_d", "markdownlint", "ruff-lsp", "shellcheck", "yamllint" }
      })
    end},

}
