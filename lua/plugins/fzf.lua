-- Fuzzy finder. Loads on the first :FzfLua or picker key, not at startup.
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- file icons
  cmd = "FzfLua",
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
    { "<leader>ft", "<cmd>FzfLua builtin<cr>", desc = "All fzf-lua pickers" },
  },
  opts = {},
}
