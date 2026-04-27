local M = {}

M.packages = {
  {
    src = "https://github.com/HiPhish/rainbow-delimiters.nvim.git",
    name = "rainbow-delimiters.nvim",
  },
}

function M.setup()
  vim.cmd("packadd rainbow-delimiters.nvim")

  local rainbow_delimiters = require("rainbow-delimiters")
  vim.g.rainbow_delimiters = {
    strategy = {
      [""] = rainbow_delimiters.strategy.global,
      vim = rainbow_delimiters.strategy["local"],
    },
    query = {
      [""] = "rainbow-delimiters",
      lua = "rainbow-blocks",
    },
    highlight = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    },
  }
end

return M
