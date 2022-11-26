local is_lsp_installer_present, lsp_installer = pcall(require, "nvim-lsp-installer")

if is_lsp_installer_present then
	lsp_installer.setup({
		automatic_installation = true,
	})
end
