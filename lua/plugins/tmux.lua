return {
  "aserowy/tmux.nvim",
  opts = {
    -- Register/clipboard sync via tmux is off; the clipboard is handled by
    -- Neovim's own clipboard option and OSC 52 over SSH, see lua/config/settings.lua
    copy_sync = {
      enable = false,
    },
  }
}
