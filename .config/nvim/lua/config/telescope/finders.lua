local finders = {}

-- find files
finders.find_files = function()
	local opts = {
        find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
	}
	require("telescope.builtin").find_files(opts)
end

-- find files in dotfiles dir
finders.find_dotfiles = function()
	local opts = {
		cwd = "~/.dotfiles",
		prompt_title = "~ dotfiles ~",
		shorten_path = false,
    find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
	}
	require("telescope.builtin").find_files(opts)
end

return finders
