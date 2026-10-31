-- Gives lua_ls the types of plugins this config uses (blink.cmp.Config, snacks.Config, ...),
-- indexing only required modules on demand, so lsp/lua_ls.lua keeps its VIMRUNTIME-only
-- library. Loaded for Lua buffers only.
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = { { path = "snacks.nvim", words = { "Snacks" } } }, -- resolve the Snacks global
  },
}
