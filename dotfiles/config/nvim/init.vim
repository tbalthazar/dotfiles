source $HOME/.dotfiles/dotfiles/config/nvim/plug.vim
source $HOME/.dotfiles/dotfiles/config/nvim/maps.vim

lua require("lsp")


" the position before the cursor marks the end of the selection
set selection=exclusive

" window
set number

" for nvim-compe
set completeopt=menuone,noselect
