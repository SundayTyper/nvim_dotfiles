return {
    "nmac427/guess-indent.nvim",
    event = "VeryLazy",
    config = function()
      require("guess-indent").setup({
        auto_cmd = true,
        override_editorconfig = true,
        on_tab_options = { -- A table of vim options when tabs are detected 
          ["expandtab"] = false,
        },
        on_space_options = { -- A table of vim options when spaces are detected 
          ["expandtab"] = true,
          ["tabstop"] = "detected", -- If the option value is 'detected', The value is set to the automatically detected indent size.
          ["softtabstop"] = "detected",
          ["shiftwidth"] = "detected",
        },
      })
    end,
}
