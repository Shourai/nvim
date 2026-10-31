-- Installs LSP servers, formatters and linters. Keep eager: setup() puts Mason's bin/
-- on $PATH, which vim.lsp.enable(), conform and nvim-lint use to find the tools.
return {
  "mason-org/mason.nvim",
  opts = {},
  init = function()
    -- Every tool this config uses (Mason package names). Keep in sync with
    -- lua/config/lsp.lua, lua/plugins/conform.lua and lua/plugins/nvim-lint.lua.
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

    -- Install only what's missing (plain :MasonInstall reinstalls installed packages)
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      local registry = require("mason-registry")
      registry.refresh(function()
        local queued = {}
        for _, name in ipairs(packages) do
          local pkg = registry.get_package(name)
          if not pkg:is_installed() and not pkg:is_installing() then
            pkg:install()
            table.insert(queued, name)
          end
        end
        vim.notify(#queued == 0 and "Mason: all packages already installed"
          or "Mason: installing " .. table.concat(queued, ", "))
      end)
    end, { desc = "Install missing Mason packages used by this config" })
  end,
}
