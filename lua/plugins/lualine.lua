-- Statusline. Default lualine config (the previous opts were exactly lualine's defaults).
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy", -- statusline appears just after the first screen draw
  opts = {},
}
