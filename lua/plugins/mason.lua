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
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig", -- Required for LSP functionality
    },
    lazy = false,
    opts = {
      automatic_installation = true,
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    lazy = false,
    opts = {
      ensure_installed = {
        -- LSP Servers
        "bash-language-server",
        "clangd",
        "copilot",
        "docker-language-server",
        "gh-actions-language-server",
        "goimports",
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
        "black",
        "clang-format",
        "cmakelang",
        "codespell",
        "cpplint",
        "cspell",
        "eslint_d",
        "hadolint",
        "isort",
        "jsonlint",
        "markdownlint",
        "prettier",
        "shellcheck",
        "shfmt",
        "sphinx-lint",
        "stylua",
        "yamllint",
      },
      auto_update = true,
      run_on_start = true,
    },
  },
}
