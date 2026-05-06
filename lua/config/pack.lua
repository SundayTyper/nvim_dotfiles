local module_names = {
  "blink-completion",
  "buff-as-tabs",
  "codesnap",
  "conform",
  "fzf-lua",
  "glyphs",
  "inline-diagnostics",
  "lazygit",
  "lisp",
  "lualine",
  "mason",
  "match",
  "mini",
  "noice",
  "nvim-lint",
  "octo",
  "overseer",
  "pi",
  "preview",
  "rainbow-delimiters",
  "render-markdown",
  "snacks",
  "theme",
  "treesitter",
  "which-key",
  "yazi",
}

local modules = {}
local packages = {}
local build_hooks = {}

--- Appends package specs from a plugin module into the shared install list.
local function add_packages(list)
  for _, spec in ipairs(list or {}) do
    packages[#packages + 1] = spec
  end
end

--- Merges named build hooks from a plugin module into the shared hook table.
local function add_build_hooks(hooks)
  for name, command in pairs(hooks or {}) do
    build_hooks[name] = command
  end
end

for _, module_name in ipairs(module_names) do
  local module = require("plugins." .. module_name)
  modules[#modules + 1] = module
  add_packages(module.packages)
  add_build_hooks(module.build_hooks)
end

--- Runs a package build hook after install or update and reports failures.
local function run_build(name, path)
  local command = build_hooks[name]
  if not command then
    return
  end

  if vim.startswith(command, ":") then
    vim.cmd("packadd " .. name)
    vim.cmd(command:sub(2))
    return
  end

  local result = vim.system({ "sh", "-c", command }, { cwd = path, text = true }):wait()
  if result.code == 0 then
    return
  end

  local message = (result.stderr or result.stdout or ""):gsub("%s+$", "")
  vim.notify(string.format("Build failed for %s: %s", name, message), vim.log.levels.ERROR)
end

local M = {}

--- Registers package loading, build hooks, and plugin module setup calls.
function M.setup()
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      local data = ev.data
      if not data or (data.kind ~= "install" and data.kind ~= "update") then
        return
      end

      run_build(data.spec.name, data.path)
    end,
  })

  vim.pack.add(packages, {
    confirm = false,
    load = false,
  })

  for _, module in ipairs(modules) do
    if type(module.setup) == "function" then
      module.setup()
    end
  end
end

return M