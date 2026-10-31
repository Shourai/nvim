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
    -- Format on :w (and :q via autowriteall). Autosaves set b:autosaving and are skipped,
    -- see lua/config/autocommands.lua.
    format_on_save = function(bufnr)
      if vim.b[bufnr].autosaving then
        return nil
      end
      return { lsp_format = "fallback", timeout_ms = 1000 }
    end,
  }
}
