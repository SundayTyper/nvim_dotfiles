local M = {}

M.packages = {
  {
    src = "https://github.com/nvim-lua/plenary.nvim.git",
    name = "plenary.nvim",
  },
  {
    src = "https://github.com/mikavilpas/yazi.nvim.git",
    name = "yazi.nvim",
  },
}

function M.setup()
  vim.g.loaded_netrwPlugin = 1

  vim.cmd("packadd plenary.nvim")
  vim.cmd("packadd yazi.nvim")
  require("yazi").setup({
    open_for_directories = false,
    keymaps = {
      show_help = "?",
    },
  })

  vim.keymap.set("n", "<leader>e", "<cmd>Yazi cwd<cr>", { desc = "Open yazi at the project root" })
end

return M
