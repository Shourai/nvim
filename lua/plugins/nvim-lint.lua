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

    lint.linters_by_ft = {
      ansible = { "ansible-lint" },
      bash = { "shellcheck" },
      json = { "jsonlint" },
      markdown = { "markdownlint-cli2" },
      python = { "ruff" },
      sh = { "shellcheck" },
      terraform = { "tflint", "terraform" },
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

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()
      end,
    })
  end,
}
