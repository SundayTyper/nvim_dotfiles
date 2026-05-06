local M = {}

M.packages = {
  {
    src = "https://github.com/kdheepak/lazygit.nvim.git",
    name = "lazygit.nvim",
  },
}

--- Configures lazygit globals, loads the plugin, and binds repo and file actions.
function M.setup()
  vim.g.lazygit_floating_window_winblend = 0
  vim.g.lazygit_floating_window_scaling_factor = 0.9
  vim.g.lazygit_use_neovim_remote = vim.fn.executable("nvr") == 1 and 1 or 0

  vim.cmd("packadd lazygit.nvim")

  vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Lazygit" })
  vim.keymap.set("n", "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", { desc = "Lazygit Current File" })
end

return M