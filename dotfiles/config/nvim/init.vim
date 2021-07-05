call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'neovim/nvim-lspconfig'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

lua require("lsp")

" the position before the cursor marks the end of the selection
set selection=exclusive

" --- window
set number
