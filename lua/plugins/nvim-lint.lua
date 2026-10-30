return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufReadPost",
    "BufNewFile",
    "InsertLeave",
  },
  config = function()
    local lint = require("lint")

    -- Python (ruff) and Terraform (tflint) are linted by their LSPs, see lua/config/lsp.lua
    lint.linters_by_ft = {
      json = { "jsonlint" },
      markdown = { "markdownlint-cli2" },
      sh = { "shellcheck" },
      yaml = { "yamllint" },
    }

    local markdownlint = require('lint').linters["markdownlint-cli2"]
    markdownlint.args = {
      "--config",
      vim.fn.stdpath('config') .. '/cfg_linters/global.markdownlint.jsonc',
    }

    local yamllint = require('lint').linters.yamllint
    yamllint.args = {
      "-c",
      vim.fn.stdpath('config') .. '/cfg_linters/yamllint.yaml',
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()
      end,
    })
  end,
}
