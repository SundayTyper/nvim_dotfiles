-- terminal.lua
return {
  {
    "akinsho/nvim-toggleterm.lua",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- Set the terminal to open in a floating window
        direction = "float",
        -- Configure the floating window appearance
        float_opts = {
          border = "curved", -- Options: 'single', 'double', 'shadow', 'curved'
          width = 80,
          height = 80,
          winblend = 3,
        },
        -- Set the keybinding to toggle the terminal
        open_mapping = [[<leader>tt]],
      })
    end,
  },
}
