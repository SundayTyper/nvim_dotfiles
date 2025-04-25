return {
  {
    "stevearc/conform.nvim",
    dependancies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    event = "VeryLazy",
    opts = {
      notify_on_error = true,
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
      },
      -- Set default options
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters = {
        clang_format = {
          prepend_args = { "--style=file", "--fallback-style=LLVM" },
        },
      },
    },
  },
}
