vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.signcolumn = "yes"
vim.opt.conceallevel = 2
vim.opt.synmaxcol = 2500

vim.opt.belloff = "all"
vim.opt.ruler = true
vim.opt.laststatus = 3
vim.opt.showtabline = 1
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.hidden = true
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.pumheight = 17
vim.opt.pumblend = 1
vim.opt.foldenable = false
vim.opt.foldlevel = 2
vim.opt.foldmethod = "indent"

vim.opt.termguicolors = true
vim.opt.syntax = "on"
vim.opt.background = "dark"

if pcall(require, "darkside") then
	vim.g.colors_name = "darkside"
	vim.cmd([[colorscheme darkside]])
end

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.showmatch = true

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.shortmess = "aoOTcF"
vim.opt.autowriteall = true
vim.opt.softtabstop = -1
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2,min:20"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 8
vim.opt.formatoptions = vim.opt.formatoptions - "c" - "r" - "o"
vim.opt.wildignore = vim.opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*", "node_modules" }
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildmode = vim.opt.wildmode - "list"
vim.opt.wildoptions = "pum"
vim.opt.list = true
vim.opt.listchars = vim.opt.listchars - "space" - "trail" - "lead" - "nbsp" - "tab"
vim.cmd([[set listchars+=tab:\ \ ,eol:¬,extends:…,precedes:…]])

-- syntax highlight for embedded code
vim.g.vimsyn_embed = "l"

-- disable builtins
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
