return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    input = { enabled = true },
    lazygit = { enabled = true },
  },
  keys = {
    { "<leader>g", function() Snacks.lazygit() end, desc = "Lazygit" },
  }
}
