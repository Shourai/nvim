local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.jq,
		null_ls.builtins.formatting.autopep8.with({ extra_args = { "--max-line-length", "120" } }),
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.flake8.with({ extra_args = { "--max-line-length", "120" } }),
		null_ls.builtins.diagnostics.yamllint,
	},
})
