local M = {}

M.packages = {
  {
    src = "https://github.com/mfussenegger/nvim-lint.git",
    name = "nvim-lint",
  },
}

--- Loads nvim-lint, assigns linters by filetype, and registers lint triggers.
function M.setup()
  vim.cmd("packadd nvim-lint")

  local lint = require("lint")
  lint.linters_by_ft = {
    c = { "cpplint" },
    cpp = { "cpplint" },
    python = { "ruff" },
    markdown = { "markdownlint" },
    javascript = { "eslint" },
    typescript = { "eslint" },
    javascriptreact = { "eslint" },
    typescriptreact = { "eslint" },
    sh = { "shellcheck" },
    bash = { "shellcheck" },
    yaml = { "yamllint" },
    json = { "jsonlint" },
    dockerfile = { "hadolint" },
    rst = { "sphinx-lint" },
  }
  lint.linters_by_ft["*"] = { "cspell" }

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })

  vim.api.nvim_create_autocmd("TextChanged", {
    group = lint_augroup,
    callback = function()
      vim.defer_fn(function()
        lint.try_lint()
      end, 100)
    end,
  })
end

return M
