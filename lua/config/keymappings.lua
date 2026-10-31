local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Window movement (Ctrl-h/j/k/l, also across tmux panes) comes from tmux.nvim, see lua/plugins/tmux.lua
-- fzf-lua keys are in lua/plugins/fzf.lua (`keys`), so the plugin loads on first use

-- source the current Lua file (e.g. after editing this config)
map("n", "<leader>rc", "<cmd>luafile %<cr>", default_opts)
