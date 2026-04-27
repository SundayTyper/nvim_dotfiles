-- Load builtin settings and features
require("config.globals")
require("config.options")

-- Load plugins through Neovim's builtin package manager.
require("config.pack").setup()

-- Load lsp, autocommands and keymaps after plugin registration.
require("config.lsp")
require("config.autocmds")
require("config.keymaps")
