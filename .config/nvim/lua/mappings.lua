local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = " "
map("n", " ", "", opts)
map("x", " ", "", opts)

-- Indentation
map("v", "<", "< gv", opts)
map("v", ">", "> gv", opts)

-- Save and quit files mapper('n', '<Leader>w', ':w!<CR>')
map("n", "<Leader>w", ":w!<CR>", opts)
map("n", "<Leader>wq", ":wq!<CR>", opts)
map("n", "<Leader>q", ":confirm wqa!<CR>", opts)

-- Find and Replace selected words in normal/visual mode with *
map("x", "<Leader>fr", ":%s///g<Left><Left>", opts)

-- Multiple cursors alternative. Under a word or selection replace word with 's*' and repeat instance with '.'
map("n", "s*", ":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn", opts)
map("x", "s*", '"sy:let @/=@s<CR>cgn', opts)

-- Current window split horizontally, vertically, equal size
map("n", "<Leader>_", "<C-w>s", opts)
map("n", "<Leader>|", "<C-w>v", opts)
map("n", "<Leader>=", "<C-w>=", opts)

-- Normal mode window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Insert mode navigation
map("i", "<C-h>", "<Esc><C-w>h", opts)
map("i", "<C-j>", "<Esc><C-w>j", opts)
map("i", "<C-k>", "<Esc><C-w>k", opts)
map("i", "<C-l>", "<Esc><C-w>l", opts)

-- Terminal window navigation
map("t", "<Esc>", "<C-\\><C-N>", opts)
map("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

-- Buffers navigation
map("n", "<Leader>bl", ":bnext<CR>", opts)
map("n", "<Leader>bh", ":bprevious<CR>", opts)
map("n", "<Leader>bq", ":bdelete<CR>", opts)

-- Tabs navigation
map("n", "<Leader>tn", ":tabnew %<CR>", opts)
map("n", "<Leader>tl", ":tabnext<CR>", opts)
map("n", "<Leader>th", ":tabprevious<CR>", opts)
map("n", "<Leader>tq", ":tabclose<CR>", opts)

-- Work around for using alt key to resize widows on mac
map("n", "˚", ":resize -2<CR>", opts)
map("n", "∆", ":resize +2<CR>", opts)
map("n", "˙", ":vertical resize -2<CR>", opts)
map("n", "¬", ":vertical resize +2<CR>", opts)

-- Opening new terminal emulators
map("n", "<Leader>tt", ":tabnew +terminal<CR>", opts)
map("n", "<Leader>ts", ":new +terminal<CR>", opts)
map("n", "<Leader>tv", ":vnew +terminal<CR>", opts)

-- CoC mappings
-- eslint when clicking <space>cl
map("n", "<Leader>cl", ":CocCommand eslint.executeAutofix<CR>", opts)
