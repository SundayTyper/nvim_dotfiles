local module_names = {
  "theme",
  "glyphs",
  "mini",
  "lazygit",
  "snacks",
  "fzf-lua",
  "grug-far",
  "treesitter",
  "blink-completion",
  "mason",
  "conform",
  "inline-diagnostics",
  "nvim-lint",
  "noice",
  "which-key",
  "lualine",
  "buff-as-tabs",
  "terminal",
  "rainbow-delimiters",
  "overseer",
  "render-markdown",
  "yazi",
  "preview",
  "codesnap",
  "goose",
  "pi",
  "lisp",
  "octo",
}

local modules = {}
local packages = {}
local build_hooks = {}

local function add_packages(list)
  for _, spec in ipairs(list or {}) do
    packages[#packages + 1] = spec
  end
end

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