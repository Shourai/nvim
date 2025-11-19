return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    -- mason, write correct names only
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      local packages = {
        "ansible-language-server",
        "ansible-lint",
        "jsonlint",
        "lua-language-server",
        "markdownlint-cli2",
        "marksman",
        "prettier",
        "pyright",
        "ruff",
        "shellcheck",
        "shfmt",
        "terraform",
        "terraform-ls",
        "tflint",
        "typescript-language-server",
        "yaml-language-server",
        "yamllint",
      }
      vim.cmd("MasonInstall " .. table.concat(packages, " "))
    end, {})
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
  },
}
