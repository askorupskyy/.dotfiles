local is_null_ls_present, null_ls = pcall(require, "null-ls")

if is_null_ls_present then
	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier,
			null_ls.builtins.diagnostics.eslint,
		},
	})
end
