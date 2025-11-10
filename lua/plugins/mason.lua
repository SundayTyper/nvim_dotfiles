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
        -- LSP Servers
        "bash-language-server",
        "clangd",
        "docker-langserver",
        "github-actions-language-server",
        "json-lsp",
        "lua-language-server",
        "marksman",
        "neocmakelsp",
        "pyright",
        "ruff",
        "tinymist",
        "typescript-language-server",
        "yaml-language-server",
        -- Linters & Formatters for efm
        "actionlint",
        "cmakelang",
        "codespell",
        "cspell",
        "eslint_d",
        "hadolint",
        "markdownlint",
        "prettier",
        "shellcheck",
        "shfmt",
        "stylua",
      },
    },
  },
}
