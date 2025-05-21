return {
  {
    "williamboman/mason.nvim",
    config = function()
      -- load mason
      local mason = require("mason")

      mason.setup({
        PATH = "prepend", -- instead of "skip"
        ui = {
          icons = {
            package_installed = "", -- tick
            package_pending = "", -- arrow
            package_uninstalled = "", -- cross
          },
        },
        automatic_installation = true,
        ensure_installed = {
          -- Linters & Formatters for efm
          "actionlint",
          "cmakelang",
          "codespell",
          "cpplint",
          "cspell",
          "hadolint",
          "markdownlint",
          "shellcheck",
          "prettier",
          "shfmt",
          "stylua",
          "eslint_d",
          "ruff",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    lazy = true,
    opts = {
      automatic_installation = true,
      ensure_installed = {
        -- LSP
        "bashls",
        "clangd",
        "dockerls",
        "efm", -- this will handle linting/formatting
        "gh_actions_ls",
        "jsonls",
        "lua_ls",
        "marksman",
        "neocmake",
        "pyright",
        "tinymist",
        "ts_ls",
        "yamlls",
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    lazy = true,
    opts = {
      automatic_installation = true,
      ensure_installed = {
        -- Formatters
        "prettier",
        "stylua",
        "shfmt",
        "clang-format",
        "cmakelang",
        -- Linters
        "ruff",
        "shellcheck",
        "markdownlint",
        "hadolint",
        "actionlint",
        "codespell",
        "cspell",
      },
    },
  },
}
