local map = function(mode, lhs, rhs)
	local opts = { noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Leader key
vim.g.mapleader = " "
map("n", " ", "")
map("x", " ", "")

-- Indentation
map("v", "<", "< gv")
map("v", ">", "> gv")

-- Save and quit files mapper('n', '<Leader>w', ':w!<CR>')
map("n", "<Leader>w", ":w!<CR>")
map("n", "<Leader>wq", ":wq!<CR>")
map("n", "<Leader>q", ":confirm wqa!<CR>")

-- Find and Replace selected words in normal/visual mode with *
map("x", "<Leader>fr", ":%s///g<Left><Left>")

-- Multiple cursors alternative. Under a word or selection replace word with 's*' and repeat instance with '.'
map("n", "s*", ":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn")
map("x", "s*", '"sy:let @/=@s<CR>cgn')

-- Current window split horizontally, vertically, equal size
map("n", "<Leader>_", "<C-w>s")
map("n", "<Leader>|", "<C-w>v")
map("n", "<Leader>=", "<C-w>=")

-- Normal mode window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Insert mode navigation
map("i", "<C-h>", "<Esc><C-w>h")
map("i", "<C-j>", "<Esc><C-w>j")
map("i", "<C-k>", "<Esc><C-w>k")
map("i", "<C-l>", "<Esc><C-w>l")

-- Terminal window navigation
map("t", "<Esc>", "<C-\\><C-N>")
map("t", "<C-h>", "<C-\\><C-N><C-w>h")
map("t", "<C-j>", "<C-\\><C-N><C-w>j")
map("t", "<C-k>", "<C-\\><C-N><C-w>k")
map("t", "<C-l>", "<C-\\><C-N><C-w>l")

-- Buffers navigation
map("n", "<Leader>bl", ":bnext<CR>")
map("n", "<Leader>bh", ":bprevious<CR>")
map("n", "<Leader>bq", ":bdelete<CR>")

-- Tabs navigation
map("n", "<Leader>tn", ":tabnew %<CR>")
map("n", "<Leader>tl", ":tabnext<CR>")
map("n", "<Leader>th", ":tabprevious<CR>")
map("n", "<Leader>tq", ":tabclose<CR>")

-- Work around for using alt key to resize widows on mac
map("n", "˚", ":resize -2<CR>")
map("n", "∆", ":resize +2<CR>")
map("n", "˙", ":vertical resize -2<CR>")
map("n", "¬", ":vertical resize +2<CR>")

-- Opening new terminal emulators
map("n", "<Leader>tt", ":tabnew +terminal<CR>")
map("n", "<Leader>ts", ":new +terminal<CR>")
map("n", "<Leader>tv", ":vnew +terminal<CR>")

map("n", "<leader>+", "<C-a>")
map("n", "<leader>-", "<C-x>")

-- Center the cursor on screen when going page-up or page-down
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "<C-d>", "<C-d>zz", opts)
