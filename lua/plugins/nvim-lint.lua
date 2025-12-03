-- nvim-lint - Modern asynchronous linter integration
-- Replaces none-ls for diagnostics/linting

return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Configure linters by filetype
      lint.linters_by_ft = {
        -- C/C++
        c = { "cpplint" },
        cpp = { "cpplint" },

        -- Python
        python = { "ruff" },

        -- Markdown
        markdown = { "markdownlint" },

        -- JavaScript/TypeScript
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },

        -- Shell scripts
        sh = { "shellcheck" },
        bash = { "shellcheck" },

        -- YAML
        yaml = { "yamllint" },

        -- JSON
        json = { "jsonlint" },

        -- Docker
        dockerfile = { "hadolint" },

        -- Sphinx
        rst = { "sphinx-lint" },
      }

      -- Configure cspell for all text-based files
      lint.linters_by_ft["*"] = { "cspell" }

      -- Create autocommand for linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      -- Lint on text changed (debounced)
      vim.api.nvim_create_autocmd({ "TextChanged" }, {
        group = lint_augroup,
        callback = function()
          -- Debounce linting to avoid performance issues
          vim.defer_fn(function()
            lint.try_lint()
          end, 100)
        end,
      })
    end,
  },
}
