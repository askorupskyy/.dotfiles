return function(config_callback)
	-- vim.cmd([[packadd packer.nvim]])
	local preset, packer = pcall(require, "packer")

	-- Install packer if not preset in ~/.local/share/nvim/site/pack/packer/start
	if not preset then
		if vim.fn.input("Download Packer? ( y for yes ) ") ~= "y" then
			return
		end

		local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath("data"))

		vim.fn.mkdir(directory, "p")

		local out = vim.fn.system(
			string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
		)

		print(out)
		print("Downloading packer.nvim...")
		print("(Restart now, then run :PackerInstall and :PackerCompile!)")
		return
	end

	packer.init({
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
			prompt_border = "single",
		},
		git = {
			clone_timeout = 6000,
		},
		auto_clean = true,
		compile_on_sync = true,
	})

	config_callback()
end
