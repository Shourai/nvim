local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Window movement (Ctrl-h/j/k/l, also across tmux panes) comes from tmux.nvim, see lua/plugins/tmux.lua

-- fzf-lua
map("n", "<leader>ff", "<cmd> FzfLua files <cr>", default_opts)
map("n", "<leader>fb", "<cmd> FzfLua buffers <cr>", default_opts)
map("n", "<leader>fg", "<cmd> FzfLua live_grep <cr>", default_opts)
map("n", "<leader>ft", "<cmd> FzfLua builtin <cr>", default_opts)

-- source the current Lua file (e.g. after editing this config)
map("n", "<leader>rc", "<cmd>luafile %<cr>", default_opts)
