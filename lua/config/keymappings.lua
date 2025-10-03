local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- better window movement
map("n", "<C-h>", "<C-w>h", default_opts)
map("n", "<C-j>", "<C-w>j", default_opts)
map("n", "<C-k>", "<C-w>k", default_opts)
map("n", "<C-l>", "<C-w>l", default_opts)

-- telescope
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", default_opts)
map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", default_opts)
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", default_opts)
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", default_opts)

--  Undotree
map("n", "<F5>", ":UndotreeToggle<CR>", default_opts)

-- reload init.lua
map("n", "<leader>rc", "<cmd>luafile %<cr>", default_opts)
