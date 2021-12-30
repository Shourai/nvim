-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'ray-x/lsp_signature.nvim'

  -- Completion
  use {
      'hrsh7th/nvim-cmp',
      requires = {
          { 'hrsh7th/cmp-nvim-lsp'},
          { 'hrsh7th/cmp-buffer'},
          { 'hrsh7th/cmp-path'},
          { 'hrsh7th/cmp-cmdline'},
          { 'hrsh7th/nvim-cmp'}
        }
  }

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'

  -- Theme
  use { 'navarasu/onedark.nvim',
  config =
  function()
    vim.cmd("colorscheme onedark")
  end
}

  -- Autopairs
  use 'windwp/nvim-autopairs'

  -- Easy align
  use 'junegunn/vim-easy-align'

  -- nvim-tree
  use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
  }

  -- Toggleterm
  use {"akinsho/toggleterm.nvim"}

  -- Indentation guides
  use {"lukas-reineke/indent-blankline.nvim"}

  -- lspkind-nvim
  use {"onsails/lspkind-nvim"}

  -- Vim surround
  use 'tpope/vim-surround'

  -- Git signs
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  -- Modeline
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Comments
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- Vim table mode
  use {'dhruvasagar/vim-table-mode', opt = true, cmd = { "TableModeEnable", "TableModeToggle"}}

  -- Tmux
  use {
    "aserowy/tmux.nvim",
    config = function()
      require("tmux").setup({
        copy_sync = {
          enable = true,
          redirect_to_clipboard = true,
          register_offset = 0,
          sync_clipboard = false,
          sync_deletes = true,
        },
        navigation = { enable_default_keybindings = true },
        resize = { enable_default_keybindings = true } })
      end
    }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
