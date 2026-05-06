local M = {}

M.packages = {
  {
    src = "https://github.com/rebelot/kanagawa.nvim.git",
    name = "kanagawa.nvim",
  },
}

--- Loads the colorscheme and applies local highlight overrides.
function M.setup()
  vim.cmd("packadd kanagawa.nvim")
  vim.cmd("colorscheme kanagawa-wave")

  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#FF96BD", bold = true })
  vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#223249" })
  vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#223249" })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#3D2B3D", underline = true })
  vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#1F1F28" })
  vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { fg = "#54546D" })
  vim.api.nvim_set_hl(0, "TreesitterContextBottom", { sp = "#54546D", underline = true })
end

return M
