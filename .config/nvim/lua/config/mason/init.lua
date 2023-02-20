local is_mason_present, mason = pcall(require, "mason")
if not is_mason_present then
	return
end

local is_mason_lsp_present, mason_lspconfig = pcall(require, "mason-lspconfig")
if not is_mason_lsp_present then
	return
end

local is_mason_null_ls_present, mason_null_ls = pcall(require, "mason-null-ls")
if not is_mason_null_ls_present then
	return
end

local ensure_installed_servers = {
	"astro",
	"bashls",
	"cmake",
	"cssls",
	"dockerls",
	"dotls",
	"elixirls",
	"gopls",
	"graphql",
	"html",
	"intelephense",
	"jsonls",
	"prismals",
	"sumneko_lua",
	"rust_analyzer",
	"tailwindcss",
	"tsserver",
	"vimls",
	"vuels",
	"yamlls",
	"intelephense",
}

mason.setup()
mason_lspconfig.setup({
	ensure_installed = ensure_installed_servers,
	automatic_installation = true,
})
mason_null_ls.setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"eslint_d",
	},
	automatic_installation = true,
})
require("config.mason.lsp_config")
require("config.mason.lsp_mappings")
require("config.mason.format_and_lint")
