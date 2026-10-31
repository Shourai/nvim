-- Global keymaps. Plugin keys live in their spec's `keys` (lua/plugins/), the Python runner
-- keys in after/ftplugin/python.lua, and LSP keys are Neovim's defaults (see README).
local map = vim.keymap.set
-- vim.keymap.set is non-recursive by default (remap = false); only `desc` needs passing.

-- Window movement (Ctrl-h/j/k/l, also across tmux panes) comes from tmux.nvim, see lua/plugins/tmux.lua

-- Re-source the current Lua/Vim config file. lazy.nvim refuses a second setup(), and plugin
-- specs are only read at startup, so warn instead of failing silently for those.
map("n", "<leader>rc", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file:find("/lua/plugins/", 1, true) or file:match("config/lazy%.lua$") then
    vim.notify("Plugin specs are read at startup only: use :restart", vim.log.levels.WARN)
    return
  end
  vim.cmd.source(file) -- :source handles both .lua and .vim
end, { desc = "Source the current config file" })
