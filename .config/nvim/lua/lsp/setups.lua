local is_lspconfig_present, lspconfig = pcall(require, "lspconfig")
local is_null_ls_present, null_ls = pcall(require, "null-ls")

if is_lspconfig_present then
	-- https://github.com/golang/tools/tree/master/gopls
	lspconfig.gopls.setup({})

	-- https://github.com/rust-lang/rust-analyzer
	lspconfig.rust_analyzer.setup({})

	-- https://github.com/rcjsuen/dockerfile-language-server-nodejs
	lspconfig.dockerls.setup({})

	-- https://github.com/hrsh7th/vscode-langservers-extracted
	lspconfig.jsonls.setup({})

	-- https://github.com/sumneko/lua-language-server
	lspconfig.sumneko_lua.setup({
		settings = {
			Lua = {
				format = { enable = false },
				runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
				diagnostics = { enable = true, globals = { "vim", "use", "cmp", "packer_plugins" } },
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
				},
			},
		},
	})

	-- https://github.com/hrsh7th/vscode-langservers-extracted
	lspconfig.html.setup({
		filetypes = {
			"html",
			"tsx",
			"jsx",
			"vue",
			"hbs",
			"handlebars",
			"liquid",
		},
	})

	-- https://github.com/hrsh7th/vscode-langservers-extracted
	lspconfig.cssls.setup({
		settings = {
			css = { validate = false },
		},
	})

	-- https://github.com/tailwindlabs/tailwindcss-intellisense
	lspconfig.tailwindcss.setup({
		settings = {
			includeLanguages = {
				typescript = "javascript",
				typescriptreact = "javascript",
        astro = "html",
			},
			tailwindCSS = {
				experimental = {
					classRegex = {
						"tw`([^`]*)",
						'tw="([^"]*)',
						'tw={"([^"}]*)',
						"tw\\.\\w+`([^`]*)",
						"tw\\(.*?\\)`([^`]*)",
					},
				},
			},
		},
	})

	-- https://github.com/typescript-language-server/typescript-language-server
	lspconfig.tsserver.setup({
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
		commands = {
			OrganizeImports = {
				description = "Organize Imports",
				function()
					vim.lsp.buf.execute_command({
						title = "",
						command = "_typescript.organizeImports",
						arguments = { vim.api.nvim_buf_get_name(0) },
					})
				end,
			},
		},
	})

  -- python
  lspconfig.pyright.setup({})

  -- astro
  lspconfig.astro.setup({})

  -- c++, c, swift
  lspconfig.sourcekit.setup{}

  -- prisma orm
  lspconfig.prismals.setup{}

	-- https://github.com/jose-elias-alvarez/null-ls.nvim
	if is_null_ls_present then
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.eslint,
			},
		})
	end
end
