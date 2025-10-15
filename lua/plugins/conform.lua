return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      markdown = { "markdownlint-cli2" },
      sh = { "shellcheck", "shfmt" },
    },
    format_after_save = {
      lsp_format = "fallback",
    }
  }
}
