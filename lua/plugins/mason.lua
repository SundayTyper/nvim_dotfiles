return {
  {
    "williamboman/mason.nvim",
    opts = {
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
        "clangd",
        "cmakelang",
        "codespell",
        "cspell",
        "lua-language-server",
        "markdownlint",
        "shellcheck",
        "stylua",
        "ruff",
      },
    },
  },
}
