return {
  "aserowy/tmux.nvim",
  opts = {
    copy_sync = {
      -- overwrites vim.g.clipboard to redirect * and + to the system
      -- clipboard using tmux. If you sync your system clipboard without tmux,
      -- disable this option!
      sync_clipboard = false,
    },
  }
}
