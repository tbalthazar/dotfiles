-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'christoomey/vim-tmux-navigator',
  },
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup {
        renderer = {
          indent_markers = {
            enable = true,
          },
          icons = {
            git_placement = 'signcolumn',
            show = {
              file = false,
              folder = false,
              folder_arrow = false,
              git = true,
            },
            glyphs = {
              symlink = '',
            },
          },
        },
      }
    end,
  },
}
