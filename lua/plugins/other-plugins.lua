return {
	-- Easy align
	"junegunn/vim-easy-align",

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
