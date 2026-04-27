local M = {}

M.packages = {
  {
    src = "https://github.com/MagicDuck/grug-far.nvim.git",
    name = "grug-far.nvim",
  },
}

local function current_file_path()
  local path = vim.fn.expand("%:p")
  if path == "" then
    return nil
  end

  return vim.fn.fnameescape(path)
end

local function open_search_replace(opts)
  local instance = require("grug-far").open(opts or {})
  instance:when_ready(function()
    instance:goto_input("replacement")
  end)
end

function M.setup()
  vim.cmd("packadd grug-far.nvim")
  require("grug-far").setup({
    transient = true,
    visualSelectionUsage = "auto-detect",
    openTargetWindow = {
      preferredLocation = "right",
    },
  })

  vim.keymap.set({ "n", "x" }, "<leader>sr", function()
    open_search_replace()
  end, { desc = "Search and replace in project" })

  vim.keymap.set({ "n", "x" }, "<leader>sR", function()
    local path = current_file_path()
    open_search_replace({
      prefills = {
        paths = path,
      },
    })
  end, { desc = "Search and replace in current file" })
end

return M