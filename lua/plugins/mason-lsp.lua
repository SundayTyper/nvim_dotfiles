return {
  {
    "williamboman/mason.nvim",
    dependencies = {
    },
    config = function()
        require("mason")
    end,
  },
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
        "pylint",
        "isort",
        "black",
        "codespell",
        "trim_whitespace",
        "eslint_d",
      },
      automatic_installation = true,
    },
  },
}
