local M = {}

M.packages = {
  {
    src = "https://github.com/MunifTanjim/nui.nvim.git",
    name = "nui.nvim",
  },
  {
    src = "https://github.com/rcarriga/nvim-notify.git",
    name = "nvim-notify",
  },
  {
    src = "https://github.com/folke/noice.nvim.git",
    name = "noice.nvim",
  },
}

--- Loads Noice and its UI dependencies, then applies the default setup.
function M.setup()
  vim.cmd("packadd nui.nvim")
  vim.cmd("packadd nvim-notify")
  vim.cmd("packadd noice.nvim")
  require("noice").setup({})
end

return M
