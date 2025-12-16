vim.lsp.enable({
	"gopls",
	"pyright",
})

vim.api.nvim_create_user_command("PyrightRestart", function()
  local stopped = false
  for _, c in ipairs(vim.lsp.get_clients({ name = "pyright" })) do
    c.stop()
    stopped = true
  end

  if stopped then
    vim.cmd("edit")
    print("Pyright restarted")
  else
    print("Pyright not running")
  end
end, {})

