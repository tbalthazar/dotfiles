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

syntax on
colorscheme onedark

let g:vimwiki_list = [{'path': '~/Nextcloud/Notes',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
