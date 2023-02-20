local is_lspconfig_present, lspconfig = pcall(require, "lspconfig")
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not cmp_nvim_lsp_status then
	return
end

-- Lsp configurations
if is_lspconfig_present then
	local capabilities = cmp_nvim_lsp.default_capabilities()

	require("mason-lspconfig").setup_handlers({
		-- Apply default setups to most installed servers
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
			})
		end,
		-- Override some certain servers
		["cssls"] = function()
			lspconfig.cssls.setup({
				capabilities = capabilities,
				settings = {
					css = { validate = false },
				},
			})
		end,
		["html"] = function()
			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html", "tsx", "jsx", "vue" },
			})
		end,
		["sumneko_lua"] = function()
			lspconfig.sumneko_lua.setup({
				capabilities = capabilities,
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
		end,
		["tailwindcss"] = function()
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				settings = {
					includeLanguages = {
						typescript = "javascript",
						typescriptreact = "javascript",
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
		end,
		["tsserver"] = function()
			lspconfig.tsserver.setup({
				capabilities = capabilities,
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
		end,
	})
end
