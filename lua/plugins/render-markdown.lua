local M = {}

M.packages = {
  {
    src = "https://github.com/MeanderingProgrammer/render-markdown.nvim.git",
    name = "render-markdown.nvim",
  },
}

function M.setup()
  vim.cmd("packadd render-markdown.nvim")

  require("render-markdown").setup({
    completions = {
      lsp = { enabled = true },
    },
    enabled = true,
    render_modes = { "n", "c", "t" },
  })

  vim.keymap.set("n", "<leader>m", "<nop>", { desc = "+markdown" })
  vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle Markdown Rendering" })
  vim.keymap.set("n", "<leader>me", "<cmd>RenderMarkdown expand<cr>", { desc = "Expand Anti-Conceal" })
  vim.keymap.set("n", "<leader>mc", "<cmd>RenderMarkdown contract<cr>", { desc = "Contract Anti-Conceal" })
  vim.keymap.set("n", "<leader>mp", "<cmd>RenderMarkdown preview<cr>", { desc = "Preview Markdown" })
end

return M
