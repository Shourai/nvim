-- Markdown preview, used only as a split preview (<leader>ms).
return {
  "OXY2DEV/markview.nvim",
  -- Upstream: don't lazy-load; markview lazy-loads itself and gets slower if deferred.
  -- `keys` below only defines the mapping.
  lazy = false,
  opts = {
    preview = { enable = false }, -- no in-buffer rendering; only the split preview is used
  },
  keys = {
    { "<leader>ms", "<cmd>Markview splitToggle<cr>", desc = "Markview split preview" },
  },
}
