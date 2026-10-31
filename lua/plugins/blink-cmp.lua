-- Completion. Must load at startup: plugin/blink-cmp.lua adds blink's LSP capabilities via
-- vim.lsp.config("*") when it loads, so lazy-loading would start servers without them.
return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" }, -- snippet source
  version = "1.*", -- release tags ship the prebuilt Rust fuzzy matcher (no cargo build)

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "super-tab" }, -- Tab accepts, VS Code style (see README)
    signature = { enabled = true },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      -- Show docs after 1 s instead of only on <C-space> (blink's default)
      documentation = { auto_show = true, auto_show_delay_ms = 1000 },
      ghost_text = { enabled = true },
    },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    cmdline = {
      -- Default cmdline Tab only shows/selects; make it accept, like insert mode
      keymap = { ["<Tab>"] = { "show", "accept" } },
      completion = { menu = { auto_show = true } },
    },
  },
  opts_extend = { "sources.default" },
}
