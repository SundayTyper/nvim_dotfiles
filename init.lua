vim.g.leaderkey = " "

-- Define basic settings
local O = require("config.options")
local A = require("config.autocmds")
local K = require("config.keymaps")

-- Apply options
for k, v in pairs(O.options) do
  vim.opt[k] = v
end

for name, cmd in pairs(O.commands) do
  vim.api.nvim_command(cmd) -- Run commands that set options
end

-- Apply autocmds
for event, patterns in pairs(A.commands) do
  for pattern, callback in pairs(patterns) do
    vim.api.nvim_create_autocmd(event, {
      pattern = pattern,
      callback = callback,
    })
  end
end

-- Apply mappings
for mode, mappings in pairs(K.mappings) do
  for lhs, rhs in pairs(mappings) do
    vim.keymap.set(mode, lhs, rhs, { expr = type(rhs) == "function" }) -- Handle expr
  end
end

-- Call in config
require("config.lazy")
