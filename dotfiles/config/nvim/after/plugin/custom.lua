-- debug example:
-- local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
-- if filetype == "go" then
--   vim.cmd [[autocmd BufWritePost <buffer> :lua print("go")]]
-- else
--   vim.cmd [[autocmd BufWritePost <buffer> :lua print("not go")]]
-- end

-- My Custom Config

vim.keymap.set('n', '<leader><space>', function()
  require('telescope.builtin').buffers({
    -- Sorts current and last buffer to the top and selects the lastused
    sort_lastused = true,
  })
end, { desc = '[ ] Find existing buffers' })

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-d>'] = require('telescope.actions').delete_buffer,
      },
    },
  },
}

local opts = { noremap = false, silent = true }
vim.keymap.set("n", "<leader>t", "<cmd>TestNearest<CR>", opts)
vim.keymap.set("n", "<leader>T", "<cmd>TestFile<CR>", opts)
vim.keymap.set("n", "<leader>a", "<cmd>TestSuite<CR>", opts)
vim.keymap.set("n", "<leader>l", "<cmd>TestLast<CR>", opts)
vim.keymap.set("n", "<leader>g", "<cmd>TestVisit<CR>", opts)

require('lualine').setup {
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1
      }
    },
  },
  inactive_sections = {
    lualine_c = {
      {
        'filename',
        path = 1
      }
    },
  },
}

require("nvim-tree").setup({
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "signcolumn",
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = true,
      },
      glyphs = {
        symlink = "",
      },
    },
  },
})

vim.keymap.set("n", "<leader>fe", "<cmd>NvimTreeToggle<CR>", opts)
