local M = {}

M.packages = {
  {
    src = "https://github.com/akinsho/nvim-toggleterm.lua.git",
    name = "nvim-toggleterm.lua",
    version = vim.version.range("*"),
  },
}

function M.setup()
  vim.cmd("packadd nvim-toggleterm.lua")
  require("toggleterm").setup({
    direction = "float",
    float_opts = {
      border = "curved",
      width = 160,
      height = 80,
      winblend = 3,
    },
  })

  vim.keymap.set("n", "<leader>t", "<nop>", { desc = "+terminal" })
  vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
end

return M
