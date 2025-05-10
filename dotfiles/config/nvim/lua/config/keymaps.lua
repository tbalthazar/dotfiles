-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- neo-tree
--
-- Toggle
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neo-tree" })

-- fzf-lua
--
-- Find Files
vim.keymap.set("n", "<leader>f", function()
	require("fzf-lua").files()
end, { desc = "FZF: Find Files" })
-- Find Git Files
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").git_files()
end, { desc = "FZF: Find Git Files" })
-- Find Recent Files
vim.keymap.set("n", "<leader>fr", function()
	require("fzf-lua").oldfiles()
end, { desc = "FZF: Find Recent Files" })
-- Find Buffers
vim.keymap.set("n", "<leader>b", function()
	require("fzf-lua").buffers()
end, { desc = "FZF: Buffers" })
-- Grep files
vim.keymap.set("n", "<leader>g", function()
	require("fzf-lua").live_grep()
end, { desc = "FZF: Grep files" })
-- Search registers
vim.keymap.set("n", '<leader>s"', function()
	require("fzf-lua").registers()
end, { desc = "FZF: Registers" })
-- Search Commands History
vim.keymap.set("n", "<leader>sc", function()
	require("fzf-lua").command_history()
end, { desc = "FZF: Command History" })
-- Search Commands
vim.keymap.set("n", "<leader>sC", function()
	require("fzf-lua").commands()
end, { desc = "FZF: Commands" })
-- Search Document Diagnostics
vim.keymap.set("n", "<leader>sd", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "FZF: Document Diagnostics" })
-- Search Workspace Diagnostics
vim.keymap.set("n", "<leader>sd", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF: Workspace Diagnostics" })
-- Search Help
vim.keymap.set("n", "<leader>sh", function()
	require("fzf-lua").help_tags()
end, { desc = "FZF: Help" })
-- Grep Word
vim.keymap.set("n", "<leader>sw", function()
	require("fzf-lua").grep_cword()
end, { desc = "FZF: Grep" })
vim.keymap.set("v", "<leader>sw", function()
	require("fzf-lua").grep_cword()
end, { desc = "FZF: Grep" })

-- LSP: Goto definition
vim.keymap.set("n", "gd", function()
	require("fzf-lua").lsp_definitions()
end, { desc = "Goto definition" })
-- LSP: References
vim.keymap.set("n", "gr", function()
	require("fzf-lua").lsp_references()
end, { desc = "FZF: references" })
-- LSP: Goto implementation
vim.keymap.set("n", "gI", function()
	require("fzf-lua").lsp_implementations()
end, { desc = "Goto implementation" })
-- LSP: Goto type definition
vim.keymap.set("n", "gy", function()
	require("fzf-lua").lsp_typedefs()
end, { desc = "Goto Type Definition" })
-- LSP: Search symbols
vim.keymap.set("n", "ss", function()
	require("fzf-lua").lsp_document_symbols()
end, { desc = "FZF: symbols" })
