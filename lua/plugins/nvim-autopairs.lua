return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {},
	config = function()
		local npairs = require("nvim-autopairs")
		npairs.setup({
			fast_wrap = {},
		})

		-- nvim-autopairs settings for completion
		-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		-- local cmp = require("cmp")
		-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
	-- use opts = {} for passing setup options
	-- this is equivalent to setup({}) function
}
