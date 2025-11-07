-- Load builtin settings and features
require("config.globals")
require("config.options")
require("config.autocmds")
require("config.keymaps")

-- Load lazy plugin manager. This calls plugins and themes. Exposes commands
-- before attempting to set keybindings below
require("config.lazy")

-- load lsp and settings after mason can install them
require("config.lsp")
