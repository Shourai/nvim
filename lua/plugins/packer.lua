return require('packer').startup(function()

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'ray-x/lsp_signature.nvim'

  -- Completion
  use 'L3MON4D3/LuaSnip'
  use {
      'hrsh7th/nvim-cmp',
      requires = {
          { 'hrsh7th/cmp-buffer'},
          { 'hrsh7th/cmp-nvim-lsp'},
          { 'hrsh7th/cmp-nvim-lua'},
          { 'hrsh7th/cmp-path'},
          { 'hrsh7th/cmp-cmdline'}
        }
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'

  -- Theme
  use 'NTBBloodbath/doom-one.nvim'
  use 'navarasu/onedark.nvim'

  -- Autopairs
  use 'windwp/nvim-autopairs'

  -- Easy align
  use 'junegunn/vim-easy-align'

  -- nvim-tree
  use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function() require'nvim-tree'.setup {} end
  }

  -- Toggleterm
  use {"akinsho/toggleterm.nvim"}

  -- Indentation guides
  use {"lukas-reineke/indent-blankline.nvim",
       config = function() require "indent_blankline".setup{} end
     }

  -- lspkind-nvim
  use {"onsails/lspkind-nvim"}

  -- Useful plugins
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
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
  end)