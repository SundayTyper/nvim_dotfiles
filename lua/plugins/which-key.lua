local M = {}

M.packages = {
  {
    src = "https://github.com/folke/which-key.nvim.git",
    name = "which-key.nvim",
  },
}

function M.setup()
  vim.cmd("packadd which-key.nvim")
  local wk = require("which-key")

  wk.setup({
    triggers = {
      { "<auto>", mode = "nxso" },
      { "g", mode = "n" },
      { "[", mode = "n" },
      { "]", mode = "n" },
    },
  })

  wk.add({
    { "ga", group = "calls", mode = "n" },
    { "<CR>", desc = "Tree-sitter Increment Selection", mode = "n" },
    { "<S-CR>", desc = "Tree-sitter Scope Increment", mode = "n" },
    { "<BS>", desc = "Tree-sitter Decrement Selection", mode = "n" },
  })

  vim.keymap.set("n", "<leader>?", function()
    wk.show()
  end, { desc = "Show Keymaps (which-key)" })
end

return M
