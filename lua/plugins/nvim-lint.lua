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
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      markdown = { "markdownlint" },
    }

    local markdownlint = require('lint').linters.markdownlint
    markdownlint.args = {
      "--disable",
      "MD013"
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
