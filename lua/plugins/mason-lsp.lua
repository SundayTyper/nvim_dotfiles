return {
  {
    "williamboman/mason.nvim",
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
        "isort",
        "black",
        "codespell",
        "trim_whitespace",
      },
      automatic_installation = true,
    },
  },
}
