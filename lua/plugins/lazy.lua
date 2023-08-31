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

require("lazy").setup({
    -- LSP
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"onsails/lspkind.nvim",
		"ray-x/lsp_signature.nvim",
    {
      "glepnir/lspsaga.nvim",
      branch = "main",
      dependencies = {"nvim-tree/nvim-web-devicons"}
    },

		-- Formatting and linting
		"jose-elias-alvarez/null-ls.nvim",
		"jayp0521/mason-null-ls.nvim",

		-- Completion
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lua",
			},
		},

		-- Snippets
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",

		-- Telescope
	  {
			"nvim-telescope/telescope.nvim",
			requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim"
      },
		},

		-- Treesitter
		{
			"nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
		},

		-- Theme
		{
      "navarasu/onedark.nvim" ,
      require("onedark").load(),
    },

		-- Autopairs
    {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
    },
		"windwp/nvim-ts-autotag",

		-- Easy align
		"junegunn/vim-easy-align",

		-- nvim-tree
		{
			"nvim-tree/nvim-tree.lua",
			dependencies = {
				"nvim-tree/nvim-web-devicons", -- optional, for file icons
			},
		},

		-- Toggleterm
		{
      "akinsho/toggleterm.nvim",
      version = '*'
    },

		-- Indentation guides
		"lukas-reineke/indent-blankline.nvim",

		-- Vim surround
		{
			"kylechui/nvim-surround",
			version = "*", -- Use for stability; omit to use `main` branch for the latest features
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end,
		},

		-- Git signs
		{
			"lewis6991/gitsigns.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			config = function()
				require("gitsigns").setup()
			end,
		},

		-- Modeline
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		},

		-- Comments
		{
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		},

		-- Vim table mode
		{
      "dhruvasagar/vim-table-mode",
      lazy = true,
      cmd = { "TableModeEnable", "TableModeToggle" }
    },

		-- Undo Tree
		"mbbill/undotree",

		-- Tmux
    {
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
				})
			end,
		},

})

