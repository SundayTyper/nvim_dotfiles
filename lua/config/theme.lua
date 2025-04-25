return {
  {
    {
      "pineapplegiant/spaceduck",
      config = function()
        -- Apply the spaceduck theme
        vim.cmd("colorscheme spaceduck")

        -- Customize the comment color
        vim.cmd([[
        highlight Comment guifg=#ECF0C1
      ]])

        -- Customize gutter colors
        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#FF96BD", bold = true })

        -- Add column rulers
        vim.opt.colorcolumn = "80,100"
      end,
    },
  },
}
