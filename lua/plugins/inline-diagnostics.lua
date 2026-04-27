local M = {}

M.packages = {
  {
    src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim.git",
    name = "tiny-inline-diagnostic.nvim",
  },
}

function M.setup()
  vim.cmd("packadd tiny-inline-diagnostic.nvim")

  require("tiny-inline-diagnostic").setup({
    break_line = {
      enabled = true,
    },
  })

  vim.diagnostic.config({ virtual_text = false })
end

return M
