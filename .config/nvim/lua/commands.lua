-- Remove number column from terminal emulator window
vim.cmd([[augroup cleanup_terminal]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd TermOpen * startinsert]])
vim.cmd([[autocmd TermOpen * setlocal nonumber norelativenumber]])
vim.cmd([[augroup END]])

-- Highlight on yank
vim.cmd([[autocmd TextYankPost * silent! lua vim.highlight.on_yank({ higroup="Substitute", timeout=400 })]])

-- Auto save buffer on leaving
vim.cmd([[autocmd BufLeave * if index(['lua.luapad'], &ft) == -1 | silent! update | endif]])

-- Reset treesitter highlights
vim.cmd([[command! TSResetHighlight write | edit | TSBufEnable highlight]])

-- Force formatoptions
vim.cmd([[autocmd BufWinEnter * setlocal formatoptions-=cro]])
vim.cmd([[autocmd BufRead * setlocal formatoptions-=cro]])
vim.cmd([[autocmd BufNewFile * setlocal formatoptions-=cro]])
