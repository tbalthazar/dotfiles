-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'christoomey/vim-tmux-navigator',
  },
  {
    'windwp/nvim-autopairs',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
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
