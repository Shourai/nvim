local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

execute 'packadd packer.nvim'

require('settings')
require('keymappings')
require('plugins/autopairs')
require('plugins/cmp')
require('plugins/indent-blankline')
require('plugins/lspconfig')
require('plugins/lualine')
require('plugins/nvim-tree')
require('plugins/packer')
require('plugins/telescope')
require('plugins/toggleterm')
require('plugins/treesitter')
