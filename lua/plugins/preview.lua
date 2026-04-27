local M = {}

M.packages = {
  {
    src = "https://github.com/chomosuke/typst-preview.nvim.git",
    name = "typst-preview.nvim",
  },
  {
    src = "https://github.com/hat0uma/csvview.nvim.git",
    name = "csvview.nvim",
  },
  {
    src = "https://github.com/toppair/peek.nvim.git",
    name = "peek.nvim",
  },
  {
    src = "https://github.com/sylvanfranklin/omni-preview.nvim.git",
    name = "omni-preview.nvim",
  },
}

M.build_hooks = {
  ["peek.nvim"] = "deno task --quiet build:fast",
}

function M.setup()
  vim.cmd("packadd typst-preview.nvim")
  vim.cmd("packadd csvview.nvim")
  vim.cmd("packadd peek.nvim")
  vim.cmd("packadd omni-preview.nvim")
  require("omni-preview").setup({})

  vim.keymap.set("n", "<leader>p", "<nop>", { desc = "+preview" })
  vim.keymap.set("n", "<leader>po", "<cmd>OmniPreview start<CR>", { desc = "OmniPreview Start" })
  vim.keymap.set("n", "<leader>pc", "<cmd>OmniPreview stop<CR>", { desc = "OmniPreview Stop" })
end

return M
