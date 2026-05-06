local M = {}

M.packages = {
  {
    src = "https://github.com/williamboman/mason.nvim.git",
    name = "mason.nvim",
  },
  {
    src = "https://github.com/neovim/nvim-lspconfig.git",
    name = "nvim-lspconfig",
  },
  {
    src = "https://github.com/williamboman/mason-lspconfig.nvim.git",
    name = "mason-lspconfig.nvim",
  },
  {
    src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim.git",
    name = "mason-tool-installer.nvim",
  },
}

--- Loads Mason and related helpers, then configures LSP servers and tool installs.
function M.setup()
  vim.cmd("packadd mason.nvim")
  vim.cmd("packadd nvim-lspconfig")
  vim.cmd("packadd mason-lspconfig.nvim")
  vim.cmd("packadd mason-tool-installer.nvim")

  require("mason").setup({
    PATH = "prepend",
    ui = {
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = "",
      },
      border = "rounded",
    },
  })

  require("mason-lspconfig").setup({
    automatic_installation = true,
    handlers = {
      function(server_name)
        require("lspconfig")[server_name].setup({})
      end,
      ["clangd"] = function()
        require("lspconfig").clangd.setup({
          cmd = {
            "clangd",
            "--log=error",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
          },
        })
      end,
    },
  })

  require("mason-tool-installer").setup({
    ensure_installed = {
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
  })
end

return M
