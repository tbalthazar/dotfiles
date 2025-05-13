vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.lsp")

-- WSL-specific setup
in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil
if in_wsl then
  require("config.wsl")
end
