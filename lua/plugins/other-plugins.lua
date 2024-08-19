return {
	-- Easy align
	"junegunn/vim-easy-align",

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

	-- Vim table mode
	{
		"dhruvasagar/vim-table-mode",
		lazy = true,
		cmd = { "TableModeEnable", "TableModeToggle" },
	},

	-- Undo Tree
	"mbbill/undotree",
}
