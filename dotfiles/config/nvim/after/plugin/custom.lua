-- debug example:
-- local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
-- if filetype == "go" then
--   vim.cmd [[autocmd BufWritePost <buffer> :lua print("go")]]
-- else
--   vim.cmd [[autocmd BufWritePost <buffer> :lua print("not go")]]
-- end


-- My Custom Config

function Go_Imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end

  vim.lsp.buf.format()
end

function Format_Code()
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

  if filetype == "go" then
    Go_Imports(2000)
  else
    vim.lsp.buf.format()
  end
end

vim.cmd [[autocmd BufWritePre <buffer> :lua Format_Code()]]


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
