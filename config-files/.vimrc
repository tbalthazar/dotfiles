" --- vim-plug : https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'msanders/snipmate.vim'
Plug 'tomtom/tcomment_vim'
Plug 'altercation/vim-colors-solarized'
Plug 'elixir-lang/vim-elixir'

call plug#end()

" --- set the ctag file
set tags=./tags;

" --- Use Ack instead of grep
set grepprg=ack-grep

" --- solarized theme 
syntax enable
set background=dark
colorscheme solarized

" --- gui options
:set guioptions-=T  "remove toolbar

if (match(system("uname -s"), "Darwin") != -1)
  :set guifont=Menlo\ Regular:h14
else
  :set guifont=Monospace\ Bold\ 12
endif

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

"  -- navigate through grep search results
map <C-n> :cn<CR>
map <C-p> :cp<CR>
