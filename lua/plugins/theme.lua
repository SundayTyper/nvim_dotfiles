return {
  {
    {
      "rebelot/kanagawa.nvim",
      config = function()
        -- Apply the spaceduck theme
        vim.cmd("colorscheme kanagawa-wave")

        -- Customize gutter colors
        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#FF96BD", bold = true })
      end,
    },
  },
}
