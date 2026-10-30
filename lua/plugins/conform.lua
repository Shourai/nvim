return {
  "stevearc/conform.nvim",
  opts = {
    -- Filetypes not listed (Python, Lua, Terraform) are formatted by their LSP
    formatters_by_ft = {
      ansible = { "ansible-lint" },
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      json = { "prettier" },
      markdown = { "prettier" },
      sh = { "shfmt" },
      typescript = { "prettier" },
      yaml = { "prettier" },
    },
    format_on_save = {
      lsp_format = "fallback",
    }
  }
}
