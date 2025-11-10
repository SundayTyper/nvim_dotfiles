-- Load builtin settings and features
require("config.globals")
require("config.options")

-- Load lazy plugin manager. This calls plugins and themes. Exposes commands
-- before attempting to set keybindings below
require("config.lazy")

-- load lsp, autocommands and keymaps after lazy installs packages
require("config.lsp")
require("config.autocmds")
require("config.keymaps")
