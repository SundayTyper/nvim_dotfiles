return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- load mason
      local mason = require("mason")

      -- load mason-lspconfig
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup({
        ui = {
          icons = {
            package_installed = "", -- tick
            package_pending = "", -- arrow
            package_uninstalled = "", -- cross
          },
        },
      })

      -- list lsp servers
      mason_lspconfig.setup({
        ensure_installed = {
          "actionlint",
          "clangd",
          "clang-format",
          "cmakelang",
          "cmakelint",
          "ts_ls",
          "prettierd",
          "prettier",
          "lua_ls",
          "stylua",
          "yamlls",
          "pyright",
          "pylint",
          "isort",
          "black",
          "codespell",
          "trim_whitespace",
          "eslint_d",
          "tinymist",
        },
        automatic_installation = true,
      })
    end,
  },
}
