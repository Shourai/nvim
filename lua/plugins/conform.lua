return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      markdown = { "markdownlint" },
      sh = { "shellcheck", "shfmt" },
    },
    format_after_save = {
      lsp_format = "fallback",
    }
  }
}
