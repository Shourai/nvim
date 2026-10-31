-- Shows diagnostics inline next to the cursor line. Neovim 0.11+ already defaults
-- virtual_text to false, so no vim.diagnostic.config() is needed here.
return { "rachartier/tiny-inline-diagnostic.nvim", event = "VeryLazy", opts = {} }
