require("telescope").setup {
  defaults = {
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
