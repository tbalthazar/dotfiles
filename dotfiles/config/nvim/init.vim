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

let g:vimwiki_global_ext = 0
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

" a custom test strategy found in:
" https://github.com/vim-test/vim-test/issues/448
function! CustomStrategy(cmd)
  execute 'bel 10 new'
  call termopen(a:cmd)
  wincmd p " switch back to last window
endfunction

let test#custom_strategies = {'custom': function('CustomStrategy')}
" vim test
let test#strategy = "custom"

" vim-vsnip
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" to detect current file type: `:echo &filetype`
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.vimwiki = ['markdown']
