local M = {}

M.packages = {
  {
    src = "https://github.com/pablopunk/pi.nvim.git",
    name = "pi.nvim",
  },
}

function M.setup()
  vim.cmd("packadd pi.nvim")

  require("pi").setup({
    focus_ui = false,
    log_path = vim.fn.stdpath("state") .. "/pi.log",
  })

  vim.keymap.set({ "n", "v" }, "<leader>j", "<nop>", { desc = "+pi" })
  vim.keymap.set("n", "<leader>jj", "<cmd>PiAsk<cr>", { desc = "Ask Pi" })
  vim.keymap.set("v", "<leader>jj", "<cmd>PiAskSelection<cr>", { desc = "Ask Pi About Selection" })
  vim.keymap.set("n", "<leader>jc", "<cmd>PiCancel<cr>", { desc = "Cancel Pi" })
  vim.keymap.set("n", "<leader>jl", "<cmd>PiLog<cr>", { desc = "Show Pi Log" })
end

return M