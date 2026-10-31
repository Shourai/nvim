return {
  "mfussenegger/nvim-lint",
  -- BufReadPre loads the plugin before the file's BufReadPost, so the autocmd below still fires
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Python (ruff) and Terraform (tflint) are linted by their LSPs, see lua/config/lsp.lua
    lint.linters_by_ft = {
      json = { "jsonlint" },
      markdown = { "markdownlint-cli2" },
      sh = { "shellcheck" },
      yaml = { "yamllint" },
    }

    -- Use this repo's linter configs (cfg_linters/) instead of per-project ones
    lint.linters["markdownlint-cli2"].args = {
      "--config",
      vim.fn.stdpath("config") .. "/cfg_linters/global.markdownlint.jsonc",
    }
    lint.linters.yamllint.args = {
      "-c",
      vim.fn.stdpath("config") .. "/cfg_linters/yamllint.yaml",
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
      callback = function()
        -- Runs the linters in linters_by_ft for the current filetype
        lint.try_lint()
      end,
    })
  end,
}
