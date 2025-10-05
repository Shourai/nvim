local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- better window movement
map("n", "<C-h>", "<C-w>h", default_opts)
map("n", "<C-j>", "<C-w>j", default_opts)
map("n", "<C-k>", "<C-w>k", default_opts)
map("n", "<C-l>", "<C-w>l", default_opts)

-- fzf-lua
map("n", "<leader>ff", "<cmd> FzfLua files <cr>", default_opts)
map("n", "<leader>fb", "<cmd> FzfLua buffers <cr>", default_opts)
map("n", "<leader>fg", "<cmd> FzfLua grep <cr>", default_opts)
map("n", "<leader>ft", "<cmd> FzfLua builtin <cr>", default_opts)

-- reload init.lua
map("n", "<leader>rc", "<cmd>luafile %<cr>", default_opts)
