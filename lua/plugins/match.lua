local M = {}

M.packages = {
  {
    src = "https://github.com/ankushbhagats/match.nvim.git",
    name = "match.nvim",
  },
}

--- Loads match.nvim and registers the local match keymap namespace.
function M.setup()
  vim.cmd("packadd match.nvim")
  require("match").setup()

  vim.keymap.set("n", "<leader>%", "<nop>", { desc = "+match" })
  vim.keymap.set("n", "<leader>%s", "<cmd>Match<cr>", { desc = "Search and replace" })
  vim.keymap.set("n", "<leader>%w", "<cmd>MatchWord<cr>", { desc = "Match word under cursor" })
  vim.keymap.set("n", "<leader>%l", "<cmd>MatchLine<cr>", { desc = "Match current line" })
end

return M