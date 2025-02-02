return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "ts_ls",
        "prettierd",
        "prettier",
        "lua_ls",
        "stylua",
        "yamlls",
        "pyright",
        "isort",
        "black",
        "codespell",
        "trim_whitespace",
      },
      autoimatic_installation = true,
    },
  },
}
