local is_lspconfig_present = pcall(require, "lspconfig")

if is_lspconfig_present then
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)

			vim.keymap.set("n", "<Leader>dl", vim.diagnostic.open_float, { buffer = args.buf })
			vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, { buffer = args.buf })
			vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, { buffer = args.buf })

			if client.server_capabilities.definitionProvider then
				vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, { buffer = args.buf })
			end

			if client.server_capabilities.typeDefinitionProvider then
				vim.keymap.set("n", "<Leader>gt", vim.lsp.buf.type_definition, { buffer = args.buf })
			end

			if client.server_capabilities.signatureHelpProvider then
				vim.keymap.set("n", "<Leader>gk", vim.lsp.buf.signature_help, { buffer = args.buf })
			end

			if client.server_capabilities.implementationProvider then
				vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, { buffer = args.buf })
			end

			if client.server_capabilities.codeActionProvider then
				vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { buffer = args.buf })
			end

			if client.server_capabilities.documentFormattingProvider then
				vim.cmd([[augroup Format]])
				vim.cmd([[autocmd! * <buffer>]])
				vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
				vim.cmd([[augroup END]])
			end

			if client.server_capabilities.hoverProvider then
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
				vim.keymap.set("n", "<Leader>gh", vim.lsp.buf.hover, { buffer = args.buf })
			end

			if client.server_capabilities.findReferencesProvider then
				vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, { buffer = args.buf })
			end

			if client.server_capabilities.renameProvider then
				vim.keymap.set("n", "<Leader>grn", vim.lsp.buf.rename, { buffer = args.buf })
			end
		end,
	})
end
