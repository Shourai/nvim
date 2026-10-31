-- Entry point: loads the modules in lua/config/ in order.
-- Order matters:
--   settings first: <leader> must be set before lazy.nvim creates plugin keymaps
--   lazy before lsp: puts nvim-lspconfig's lsp/*.lua on the runtimepath for vim.lsp.enable()
-- The Python runner keys are set per buffer in after/ftplugin/python.lua.
require("config.settings")
require("config.filetypes")
require("config.keymappings")
require("config.lazy")
require("config.lsp")
require("config.autocommands")
