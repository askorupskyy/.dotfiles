  set nocompatible                " not compatible with Vi
  filetype plugin indent on       " mandatory for modern plugins
  syntax on                       " enable syntax highlighting
  set autoindent                  " copy indent from the previous line
  set autoread                    " reload from disk
  set backspace=indent,eol,start  " modern backspace behavior
  set belloff=all                 " disable the bell
  set cscopeverbose               " verbose cscope output
  set complete-=i                 " don't scan current on included
                                  " files for completion
  set directory=$HOME/.vim/swap/  " Place .swp files in this dir instead of working dir
  set display=lastline            " display more message text
  set encoding=UTF-8              " set default encoding
  set fillchars=vert:│,fold:·     " separator characters
  set formatoptions=tcqj          " more intuitive autoformatting
  set fsync                       " call fsync() for robust file saving
  set history=10000               " longest possible command history
  set hlsearch                    " highlight search results
  set incsearch                   " move cursor as you type when searching
  set langnoremap                 " helps avoid mappings breaking
  set laststatus=2                " always display a status line
  set listchars=tab:>\ ,trail:-,nbsp:+  " chars for :list
  set nrformats=bin,hex           " <c-a> and <c-x> support
  set ruler                       " display current line # in a corner
  set sessionoptions-=options     " do not carry options across sessions
  set shortmess=F                 " less verbose file info
  set showcmd                     " show last command in the status line
  set sidescroll=1                " smoother sideways scrolling
  set smarttab                    " tab setting aware <Tab> key
  set tabpagemax=50               " maximum number of tabs open by -p flag
  set tags=./tags;,tags           " filenames to look for the tag command
  set timeoutlen=1000             " ms to wait for next key in a sequence
  set ttimeoutlen=0               " ms to wait for next key in a sequence
  set ttyfast                     " indicates that our connection is fast
  set viminfo+=!                  " save global variables across sessions
  set wildmenu                    " enhanced command line completion
  set clipboard=unnamed           " Yank and paste with the system clipboard
  set fillchars+=vert:.           " Change vertical split character to be a space (essentially hide it)
  set splitbelow                  " Set preview window to appear at bottom
  set mouse=a                     " Enable mouse support in all modes
  set scrolloff=5                 " Set scrolloff.
  set number                      " Turn on line numbering.
  set relativenumber              " Set row numbers relative cursor's position
  set completeopt-=preview        " keep preview window closed
  set ignorecase
  set smartcase
  set nowrap                      " Stop text from wrapping when reach end of monitor
  set linebreak                   " Prevents words from split up in two lines when set wrap
  set smartindent                 " Set smart indent
  set textwidth=88                " Break lines when line length increases
  set expandtab                   " Enter spaces when tab is pressed
  set tabstop=2                   " Use 2 spaces to represent tab
  set softtabstop=2
  set shiftwidth=2                " Number of spaces to use for auto indent
  set termguicolors              " Enable true colors support


" Mappings for integration with VSCODE since I couldn't integrade Neovim init.vim file
" I might delete these mapping and implement the ones I use often in directly in the VSCODEVIM

" g Leader key
let mapleader=" "

" let localleader=" "
nnoremap <Space> <Nop>

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Find and Replace word under the cursor
nnoremap <Leader>fr :%s///g<Left><Left>

" Find and Replace selected words in visual mode
xnoremap <Leader>fr :s///g<Left><Left>

" Multiple cursors alternative. Under a word or selection replace word and repeat instance with '.'
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>

" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>

" <TAB>: completion.
inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Save and quit files
nnoremap <Leader>w  :w<CR>
nnoremap <Leader>q  :q<CR>
nnoremap <Leader>wq :wq<CR>

" Current window split horizontally, vertically, equal size
nnoremap <Leader>_ <C-w>s
nnoremap <Leader>\| <C-w>v
nnoremap <Leader>= <C-w>=

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Insert mode navigation
imap <C-h> <Esc><C-w>h
imap <C-j> <Esc><C-w>j
imap <C-k> <Esc><C-w>k
imap <C-l> <Esc><C-w>l
inoremap <C-h> <Esc><C-w>h
inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
inoremap <C-l> <Esc><C-w>l

" Quit terminal with escape
tnoremap <Esc> <C-\><C-n> :q<CR>

" Terminal window navigation
" tnoremap <C-h> <C-\><C-N><C-w>h
" tnoremap <C-j> <C-\><C-N><C-w>j
" tnoremap <C-k> <C-\><C-N><C-w>k
" tnoremap <C-l> <C-\><C-N><C-w>l
" inoremap <C-h> <C-\><C-N><C-w>h
" inoremap <C-j> <C-\><C-N><C-w>j
" inoremap <C-k> <C-\><C-N><C-w>k
" inoremap <C-l> <C-\><C-N><C-w>l

" Use alt + hjkl to resize windows
" nnoremap <silent> <M-j>    :resize -2<CR>
" nnoremap <silent> <M-k>    :resize +2<CR>
" nnoremap <silent> <M-h>    :vertical resize -2<CR>
" nnoremap <silent> <M-l>    :vertical resize +2<CR>

" Work around for using alt key to resize widows on mac
nnoremap <silent> ˚    :resize -2<CR>
nnoremap <silent> ∆    :resize +2<CR>
nnoremap <silent> ˙    :vertical resize -2<CR>
nnoremap <silent> ¬    :vertical resize +2<CR>

let g:astro_typescript = 'enable'
