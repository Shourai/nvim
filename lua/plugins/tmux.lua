-- Ctrl-h/j/k/l, Alt-h/j/k/l and Ctrl-Alt-h/j/k/l across Neovim splits and tmux panes (see README)
return {
  "aserowy/tmux.nvim",
  event = "VeryLazy", -- keymaps are created by setup(), nothing needed before the first draw
  opts = {
    -- Register/clipboard sync via tmux is off; the clipboard is handled by
    -- Neovim's own clipboard option and OSC 52 over SSH, see lua/config/settings.lua
    copy_sync = {
      enable = false,
    },
  }
}
