-- Automatically install packer
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup({
	config = {
		compile_path = vim.fn.stdpath("data") .. "/site/pack/loader/start/packer.nvim/plugin/packer_compiled.lua",
	},
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		-- LSP
		use("neovim/nvim-lspconfig")
		use("williamboman/mason.nvim")
		use("williamboman/mason-lspconfig.nvim")
		use("onsails/lspkind.nvim")
		use({ "glepnir/lspsaga.nvim", branch = "main" })
		use("ray-x/lsp_signature.nvim")

		-- Formatting and linting
		use("jose-elias-alvarez/null-ls.nvim")
		use("jayp0521/mason-null-ls.nvim")

		-- Completion
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-path" },
				{ "hrsh7th/cmp-cmdline" },
				{ "hrsh7th/cmp-nvim-lua" },
			},
		})

		-- Snippets
		use("L3MON4D3/LuaSnip")
		use("saadparwaiz1/cmp_luasnip")
		use("rafamadriz/friendly-snippets")

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		})

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
				ts_update()
			end,
		})

		-- Theme
		use("navarasu/onedark.nvim")
		require("onedark").load()

		-- Autopairs
		use("windwp/nvim-autopairs")
		use("windwp/nvim-ts-autotag")

		-- Easy align
		use("junegunn/vim-easy-align")

		-- nvim-tree
		use({
			"nvim-tree/nvim-tree.lua",
			requires = {
				"nvim-tree/nvim-web-devicons", -- optional, for file icons
			},
		})

		-- Toggleterm
		use({ "akinsho/toggleterm.nvim" })

		-- Indentation guides
		use({ "lukas-reineke/indent-blankline.nvim" })

		-- Vim surround
		use({
			"kylechui/nvim-surround",
			tag = "*", -- Use for stability; omit to use `main` branch for the latest features
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end,
		})

		-- Git signs
		use({
			"lewis6991/gitsigns.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
			},
			config = function()
				require("gitsigns").setup()
			end,
		})

		-- Modeline
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})

		-- Comments
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

		-- Vim table mode
		use({ "dhruvasagar/vim-table-mode", opt = true, cmd = { "TableModeEnable", "TableModeToggle" } })

		-- Tmux
		use({
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
		})

		-- Undo Tree
		use("mbbill/undotree")

		-- Which key
		use({
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup()
			end,
		})

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
})
