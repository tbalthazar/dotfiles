# Neovim
## Context
This Neovim setup aims to configure _IDE-like_ features (such as LSP, autocompletion, multi-languages support, modern _fuzzy file picker_, ...) while staying as _minimal_ as possible.
I tried _out of the box_ setups such as [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and [LazyVim](https://www.lazyvim.org/) but they introduce a lot of things I'm not sure to understand. LazyVim works really well, but [it _broke_ for me](https://github.com/LazyVim/LazyVim/issues/6039) at some point cause the mason plugin introduced a breaking change. It made me realize I didn't understand all the dependencies and plugins loaded by default, how they were configured and what they actually did.
Neovim 0.11 was [recently released](https://gpanders.com/blog/whats-new-in-neovim-0-11/), with some simplifications/improvements around LSP. So I decided to start from scratch, better understand what was built-in to Neovim and what plugins I would need to achieve my goals.
## Functionalities
Typical functionalities I want from my Neovim setup are:
- **LSP support**: I want a language server that understands my code to propose me suggestions, methods signatures, auto-completion, ...
- **Syntax highlighting**: I want a parser that understand the language and highlight the syntax accordingly
- **Autocompletion**: I want the UI to automatically propose me suggestions and I want a few keyboard shortcuts to navigate/accept them
- **Formatting**: I want my code to be automatically formatted when I save a file (e.g: gofmt/goimports for Go, ruff for Python, ...)
- **Fuzzy-finder UI**: I want to be able to quickly search for a file to open it, grep for a string in my project, navigate through LSP symbols with a few keystrockes
- **File system tree:** I want to be able to navigate the file system and see the tree structure of the project from within Neovim.
### How it's typically implemented
- LSP and Formatting require third-party tools that understand the code, such as gopls, goimports, pyright, ruff. [mason.vim](https://github.com/mason-org/mason.nvim) is commonly used to download those tools directly from a dedicated UI in Neovim. [mason-lsp.nvim](https://github.com/mason-org/mason-lspconfig.nvim) is used to bridge the gap between the tools installation and the LSP server configuration
- LSP support itself is built in Neovim. [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) is commonly use to integrate/configure those tools for Neovim. Default configuration for various languages [can be found here](https://github.com/neovim/nvim-lspconfig/tree/master/lsp).
- Syntax highlighting is handled by [nvim-treesitter](https://github.com/nvim-treesitter).
- Autoformatting is handled by [conform.nvim](https://github.com/stevearc/conform.nvim)
- Autocompletion is handled by [blink.cmp](https://github.com/Saghen/blink.cmp) (Neovim has basic autocompletion support but blink.cmp has a better implementation, with fuzzy matches and more)
- Fuzzy-finder UI is often added by [fzf-lua](https://github.com/ibhagwan/fzf-lua) or [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
- File system tree is often handled by [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
### How I implemented it
- Third party tools (language servers, linters, ...) are installed system-wide, outside of the context of Neovim, making it easier (for me) to reason about, understand and debug
- Neovim plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim)
- LSP configuration: since I only use a bunch of languages, I decided to cherry-pick them directly [from the nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/tree/master/lsp) plugin, so I don't have to install the plugin itself and rely on it not breaking my setup during the next update
- Syntax highlighting is handled by [nvim-treesitter](https://github.com/nvim-treesitter).
- [blink.cmp](https://github.com/Saghen/blink.cmp) is used for autocompletion, [conform.nvim](https://github.com/stevearc/conform.nvim) for autoformatting, [fzf-lua](https://github.com/ibhagwan/fzf-lua) gives me a fuzzy-finder UI and [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) is used as a file system tree explorer.
## Config
### Structure
The config structure looks like this:
```
$ tree ~/.config/nvim
/home/tb/.config/nvim
├── init.lua
├── lazy-lock.json
├── lsp
│   ├── gopls.lua
│   └── pyright.lua
└── lua
    ├── config
    │   ├── autocmds.lua
    │   ├── keymaps.lua
    │   ├── lazy.lua
    │   ├── lsp.lua
    │   └── options.lua
    └── plugins
        ├── blink.lua
        ├── conform.lua
        ├── fzf.lua
        ├── neo-tree.lua
        └── which-key.lua
```
- `init.lua`: the main config entry point, it mostly import other config files
- `lazy-lock.json`: the lock file for the `lazy.nvim` plugin, it lists currently installed Neovim plugins
- `lsp/*`: that's where the configuration for the language servers lives. `.lua` files living there are automatically included, there's no need to manually import them.
- `lua/config/*`: that's were basic Neovim config lives. Those files are imported in `init.lua`.
- `lua/config/lazy.lua`: that's where the `lazy.nvim` plugin manager is configured.
- `lua/config/lsp.lua`: that's where the LSP config is enabled (name should match the files in the `lsp` directory).
- `lua/plugins/*`: that's where Neovim plugins managed by `lazy.nvim` store their configuration. All `.lua` files in this directory are automatically imported in the `lua/config/lazy.lua` file.
### Howto
#### Add a plugin
- add a `.lua` file in `lua/plugins`, e.g: `lua/plugins/colorscheme.lua`
#### Add a new LSP server
- Make sure the language server is installed on the system and available in the `$PATH`
- Steal a default configuration from the [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/tree/master/lsp) plugin and save it in the `lsp` directory, e.g: `~/.config/nvim/lsp/gopls.lua`
- Enable it in `~/.config/nvim/lua/config/lsp.lua`, e.g:
```lua
vim.lsp.enable({
	"gopls",
	"pyright",
})
```
#### Enable or tweak an autoformatter
- Make sure the tool is installed on the system and available in the `$PATH`
- Add a line in `~/.config/nvim/lua/plugins/conform.lua`, e.g:
```lua
formatters_by_ft = {
  go = { "goimports" },
},
```
#### Debug LSP server issues
- Check the logs in `~/.local/state/nvim/lsp.log`
- In Neovim: `:checkhealth lsp`
#### Debug  formatter tools/linter issues
- Check the logs in `~/.local/state/nvim/conform.log`
#### Restart PyRight
Pyright doesn't detect when a file is added to the workspace because
"The workspace/didChangeWatchedFiles LSP client capability is now
enabled by default on Mac and Windows. Disabled on Linux since there
currently isn't a viable backend for watching files that scales well for
large directories.", as seen here:
https://neovim.io/doc/user/news-0.10.html

When I add a new python file and import it, the LSP gives a diagonstic error
cause it cannot find the file. Running PyrightRestart will fix this. The
command has been defined in `lua/config/lsp.lua` and the
shortcut has been set in `lua/config/keymaps.lua`.
#### Add a new Neovim plugin
- Add its config in `lua/plugins`
- Verify it's correctly installed in Neovim: `:Lazy`
#### Interact with Treesitter
- Install a language parser: `:TSInstall <language_to_install>`
- Update a language parser: `:TSUpdate {language}` or `:TSUpdate all` or just `:TSUpdate`
- Interact with modules:
```
:TSBufEnable {module} " enable module on current buffer
:TSBufDisable {module} " disable module on current buffer
:TSEnable {module} [{ft}] " enable module on every buffer. If filetype is specified, enable only for this filetype.
:TSDisable {module} [{ft}] " disable module on every buffer. If filetype is specified, disable only for this filetype.
:TSModuleInfo [{module}] " list information about modules state for each filetype
```
- List of commands: [`:h nvim-treesitter-commands`](https://github.com/nvim-treesitter/nvim-treesitter/blob/master/doc/nvim-treesitter.txt)
