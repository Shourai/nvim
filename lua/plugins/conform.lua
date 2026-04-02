return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ansible = { "ansible-lint" },
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      json = { "prettier" },
      markdown = { "prettier" },
      sh = { "shfmt" },
      terraform = { "tofu_fmt" },
      typescript = { "prettier" },
      yaml = { "prettier" },
    },
    format_on_save = {
      lsp_format = "fallback",
    }
  }
}
