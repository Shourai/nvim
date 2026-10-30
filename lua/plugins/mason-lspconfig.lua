return {
  "mason-org/mason-lspconfig.nvim",
  -- Don't start every installed server; lua/config/lsp.lua is the list of servers to start
  opts = { automatic_enable = false },
  init = function()
    -- :MasonInstallAll installs every tool this config uses (Mason package names)
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
        "terraform-ls",
        "tflint",
        "typescript-language-server",
        "yaml-language-server",
        "yamllint",
      }
      vim.cmd("MasonInstall " .. table.concat(packages, " "))
    end, {})
  end,
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
  },
}
