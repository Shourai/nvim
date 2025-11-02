return {
  "OXY2DEV/markview.nvim",
  opts = {
    preview = { enable = false },
    vim.api.nvim_set_keymap("n", "<leader>ms", "<CMD>Markview splitToggle<CR>",
      { desc = "Toggles `markview` splitview." }),
  },

  -- Completion for `blink.cmp`
  -- dependencies = { "saghen/blink.cmp" },
};
