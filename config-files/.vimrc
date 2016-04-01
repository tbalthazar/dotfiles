" --- vim-plug : https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-rails'
" Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'altercation/vim-colors-solarized'
Plug 'elixir-lang/vim-elixir'
Plug 'christoomey/vim-tmux-navigator'
Plug 'fatih/vim-go'
Plug 'scrooloose/nerdtree'

call plug#end()

" --- ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" --- automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" --- zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

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

"  -- navigate through grep search results
map <C-n> :cn<CR>
map <C-p> :cp<CR>
