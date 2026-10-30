return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  opts = {
    preview = { enable = false },
  },
  keys = {
    { "<leader>ms", "<CMD>Markview splitToggle<CR>", desc = "Toggles `markview` splitview." },
  },

  -- Completion for `blink.cmp`
  -- dependencies = { "saghen/blink.cmp" },
};
