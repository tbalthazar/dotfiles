" --- vim-plug : https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" - languages
Plug 'fatih/vim-go'
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec'
Plug 'w0rp/ale'

" - config
Plug 'christoomey/vim-tmux-navigator'

" - others
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
Plug 'arcticicestudio/nord-vim'
call plug#end()

" --- leader key
let mapleader = ","

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
set tags=./tags.ctags;
nnoremap t <C-]>

" --- color theme 
syntax enable
colorscheme nord
set cursorline

" --- vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "gofmt"
let g:go_def_mapping_enabled = 0 " don't mess with ctrl-t
" let g:go_fmt_command = "goimports"

" --- vimwiki
let g:vimwiki_list = [{'path': $HOME . '/vimwiki',
                     \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_table_mappings = 0
map <Leader>x <Plug>VimwikiToggleListItem

" --- vim-rspec
let g:rspec_command = "!bundle exec rspec {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>n :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" --- ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_highlights = 0

" --- fzf
map <C-t> :FZF<CR>
map <C-y> :Buffers<CR>

" --- indentation
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab " Spaces instead of tabs
set autoindent

set smartcase

set ignorecase  " ignore case of searches
" highlight dynamically as pattern is typed
set incsearch

set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" --- undo
set undofile
set undodir=~/.vim/undodir

" --- window
set number
" enable ruler
set ruler

" --- always display filepath
set ls=2

set showcmd

"  -- navigate through grep search results
map <C-n> :cn<CR>
map <C-p> :cp<CR>

" --- add background transparency
highlight Normal ctermbg=none
highlight NonText ctermbg=none

" --- colors: list current colors  `:highlight`

" visual selection
hi Visual cterm=bold ctermbg=yellow  ctermfg=black

" match pattern
hi MatchParen cterm=none ctermbg=yellow ctermfg=black

" vimdiff colors (:help hl-DiffAdd)
hi DiffAdd    cterm=bold ctermbg=green   ctermfg=black
hi DiffDelete cterm=bold ctermbg=red     ctermfg=black
hi DiffChange cterm=bold ctermbg=blue    ctermfg=black
hi DiffText   cterm=bold ctermbg=yellow  ctermfg=black
