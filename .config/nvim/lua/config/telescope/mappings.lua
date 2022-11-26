local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<Leader>ff", [[<cmd>lua require("config/telescope/finders").find_files()<CR>]], opts)
map("n", "<Leader>fd", [[<cmd>lua require("config/telescope/finders").find_dotfiles()<CR>]], opts)
map("n", "<Leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<Leader>fs", ":Telescope grep_string<CR>", opts)
map("n", "<Leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<Leader>fl", ":Telescope current_buffer_fuzzy_find<CR>", opts)
map("n", "<Leader>fo", ":Telescope vim_options<CR>", opts)
map("n", "<Leader>fh", ":Telescope highlights<CR>", opts)
map("n", "<Leader>fc", ":Telescope commands<CR>", opts)
map("n", "<Leader>fj", ":Telescope jumplist<CR>", opts)
map("n", "<Leader>fS", ":Telescope git_status<CR>", opts)
map("n", "<Leader>fC", ":Telescope git_commits<CR>", opts)
map("n", "<Leader>fB", ":Telescope git_branches<CR>", opts)
map("n", "<Leader>fe", ":Telescope file_browser hidden=true path=%:p:h<CR>", opts)
map("n", "<Leader>fE", ":Telescope file_browser hidden=true<CR>", opts)
