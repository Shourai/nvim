local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("settings")
require("keymappings")
require("lazy").setup('plugins')


-- require("plugins/autopairs")
-- require("plugins/cmp")
-- require("plugins/indent-blankline")
-- require("plugins/lspsaga")
-- require("plugins/mason")
-- require("plugins/lspconfig")
-- require("plugins/lualine")
-- require("plugins/nvim-tree")
-- require("plugins/telescope")
-- require("plugins/toggleterm")
-- require("plugins/treesitter")
-- require("plugins/null-ls")
