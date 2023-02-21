require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "ansiblels", "bashls", "dockerls",
    "gopls", "html", "tsserver", "marksman", "pyright" }
})

require("mason-null-ls").setup({
    ensure_installed = { "stylua", "jq", "prettier", "eslint_d", "markdownlint", "flake8", "shellcheck", "yamllint" }
})
