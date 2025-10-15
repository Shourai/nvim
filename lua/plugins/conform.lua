return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      markdown = { "prettier" },
      sh = { "shellcheck", "shfmt" },
      json = { "prettier" },
      yaml = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
    },
    format_after_save = {
      lsp_format = "fallback",
    }
  }
}
