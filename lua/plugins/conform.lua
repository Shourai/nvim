return {
  "stevearc/conform.nvim",
  event = "BufWritePre", -- formatting only happens on save
  cmd = "ConformInfo",
  opts = {
    -- Filetypes not listed (Python, Lua) are formatted by their LSP
    formatters_by_ft = {
      -- yaml.ansible buffers match "ansible" before "yaml", so they get ansible-lint, not prettier
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
