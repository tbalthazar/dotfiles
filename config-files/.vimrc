" --- solarized theme 
syntax enable
set background=dark
colorscheme solarized

" --- gui options
:set guioptions-=T  "remove toolbar
:set guifont=Monospace\ Regular\ 12

" --- indentation
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab " Spaces instead of tabs
set autoindent

set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" --- window
set number

" --- shortcuts
"  -- navigate through windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
