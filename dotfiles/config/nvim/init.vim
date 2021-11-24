source $HOME/.config/nvim/plug.vim
source $HOME/.config/nvim/maps.vim

lua require("plugins/nvim-compe")
lua require("plugins/nvim-lspconfig")
lua require("plugins/nvim-telescope")
lua require("plugins/nvim-treesitter")

" the position before the cursor marks the end of the selection
set selection=exclusive

" window
set number

" for nvim-compe
set completeopt=menuone,noselect

" spaces not tabs 🤓
set tabstop=2 shiftwidth=2 expandtab

syntax on
colorscheme onedark

let g:vimwiki_list = [{'path': '~/Nextcloud/Notes',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" yank full path
nnoremap <silent> <leader>cP :let @"=expand("%:p")<cr>
" yank relative path
nnoremap <silent> <leader>cp :let @"=expand("%")<cr>

if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

map <leader>* :grep <cword> *<CR><CR>:copen<CR>

" vim test
let test#strategy = "neovim"
