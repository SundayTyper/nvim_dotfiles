return {
  "mfussenegger/nvim-lint",
  dependencies = {
    "williamboman/mason.nvim",
  },
  event = {
    "VeryLazy",
  },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      python = { "pylint" },
    }

    vim.keymap.set("n", "<leader>tl", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
