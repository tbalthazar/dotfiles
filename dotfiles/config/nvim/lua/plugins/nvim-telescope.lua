-- https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt
require("telescope").setup {
  defaults = {
    -- uses lua regexes: https://www.lua.org/manual/5.1/manual.html#5.4.1
    file_ignore_patterns = {
      "^vendor/",
      ".*/vendor/",
    },
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        width = 0.9,
      },
    },
  },
  pickers = {
    -- Your special builtin config goes in here
    -- buffers = {
    --   sort_lastused = true,
    --   theme = "dropdown",
    --   previewer = false,
    -- },
    find_files = {
      previewer = false,
    }
  },
}
