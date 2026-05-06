local M = {}

M.packages = {
  {
    src = "https://github.com/stevearc/overseer.nvim.git",
    name = "overseer.nvim",
  },
}

--- Loads Overseer and applies its default task-runner configuration.
function M.setup()
  vim.cmd("packadd overseer.nvim")
  require("overseer").setup({})
end

return M
