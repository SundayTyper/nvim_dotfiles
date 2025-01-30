return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      "folke/lazydev.nvim",
      "nvim-treesitter/nvim-treesitter",
      "joechrisellis/lsp-format-modifications.nvim",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Tree-sitter setup
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "cpp",
          "css",
          "csv",
          "bash",
          "cmake",
          "dockerfile",
          "gitignore",
          "go",
          "html",
          "javascript",
          "latex",
          "lua",
          "markdown",
          "markdown_inline",
          "ninja",
          "powershell",
          "python",
          "regex",
          "rust",
          "sql",
          "typescript",
          "vim",
          "yaml",
        },
        modules = {},
        ignore_install = {},
        sync_install = true,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })

      -- Lua LSP setup
      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
        ft = { "lua" },
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = nil -- Disable LSP semantic tokens
        end,
      })

      -- C/C++ LSP setup
      require("lspconfig").clangd.setup({
        capabilities = capabilities,
        ft = { "c", "cpp" },
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = nil -- Disable LSP semantic tokens
        end,
      })

      -- Python LSP setup
      require("lspconfig").pyright.setup({
        capabilities = capabilities,
        ft = { "py" },
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = nil -- Disable LSP semantic tokens
        end,
      })

      -- TypeScript LSP setup
      require("lspconfig").ts_ls.setup({
        capabilities = capabilities,
        ft = { "ts", "js" },
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = nil -- Disable LSP semantic tokens
        end,
      })

      -- YAML LSP setup
      require("lspconfig").yamlls.setup({
        capabilities = capabilities,
        ft = { "yaml", "yml" },
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = nil -- Disable LSP semantic tokens
        end,
        settings = {
          redhat = { telemetry = { enabled = false } },
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://json.schemastore.org/github-action.json"] = "/.github/actions/*",
            },
            editor = {
              tabSize = {
                4,
              },
            },
            validate = true,
          },
        },
      })
    end,
  },
}
