return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ansible = { "ansible-lint --fix" },
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      json = { "prettier" },
      markdown = { "prettier" },
      sh = { "shellcheck", "shfmt" },
      terraform = { "tofu_fmt" },
      typescript = { "prettier" },
      yaml = { "prettier" },
    },
    format_on_save = {
      lsp_format = "fallback",
    }
  }
}
