-- Render Markdown - Live markdown rendering in Neovim
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
    },
    lazy = true,
    ft = { "markdown" },
    opts = {
      completions = {
        lsp = { enabled = true },
      },
      enabled = true, -- Enable rendering by default
      render_modes = { 'n', 'c', 't' },
    },
    keys = {
        { "<leader>m", "<noop>", desc = "+markdown" },
      { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown Rendering" },
      { "<leader>me", "<cmd>RenderMarkdown expand<cr>", desc = "Expand Anti-Conceal" },
      { "<leader>mc", "<cmd>RenderMarkdown contract<cr>", desc = "Contract Anti-Conceal" },
      { "<leader>mp", "<cmd>RenderMarkdown preview<cr>", desc = "Preview Markdown" },
    },
  },
}
