-- Only supplies server configs (lsp/*.lua) for vim.lsp.enable() in lua/config/lsp.lua.
-- Keep it eager: the configs must be on the runtimepath before the first FileType event.
-- Local overrides live in this repo's lsp/ directory.
return { "neovim/nvim-lspconfig" }
