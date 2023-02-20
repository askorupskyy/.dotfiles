local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions

local map = function(m, lhs, rhs)
	local opts = { noremap = true, silent = true }
	vim.keymap.set(m, lhs, rhs, opts)
end

map("n", "<Leader>ff", require("config/telescope/finders").find_files)
map("n", "<Leader>fd", require("config/telescope/finders").find_dotfiles)
map("n", "<Leader>fg", builtin.live_grep)
map("n", "<Leader>fs", builtin.grep_string)
map("n", "<Leader>fb", builtin.buffers)
map("n", "<Leader>fl", builtin.current_buffer_fuzzy_find)
map("n", "<Leader>fo", builtin.vim_options)
map("n", "<Leader>fh", builtin.highlights)
map("n", "<Leader>fc", builtin.commands)
map("n", "<Leader>fj", builtin.jumplist)
map("n", "<Leader>fS", builtin.git_status)
map("n", "<Leader>fC", builtin.git_commits)
map("n", "<Leader>fB", builtin.git_branches)
map("n", "<Leader>fE", extensions.file_browser.file_browser)
map("n", "<Leader>fe", function()
	extensions.file_browser.file_browser({ hidden = true, path = "%:p:h", respect_gitignore = false })
end)
