return {
  {
    "williamboman/mason.nvim",
    lazy = false, -- Load on startup to install tools
    priority = 100, -- Load before other plugins that might need tools
    
    opts = {
      PATH = "prepend", -- instead of "skip"
      ui = {
        icons = {
          package_installed = "", -- tick
          package_pending = "", -- arrow
          package_uninstalled = "", -- cross
        },
        border = "rounded",
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
        -- Linters & Formatters
        "actionlint",
        "clang-format",
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
