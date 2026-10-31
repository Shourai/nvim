-- Bootstrap lazy.nvim: clone it on first start
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then -- config targets 0.12+, so vim.uv always exists
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } }, -- one spec per file in lua/plugins/
  install = { colorscheme = { "onedark", "habamax" } }, -- theme used during the first-run install
  -- Check for updates in the background; the count shows in :Lazy. Apply with :Lazy sync.
  checker = { enabled = true, notify = false },
})
