return {
  {
    "creativenull/efmls-configs-nvim",
    lazy = true,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
    },
    -- LazyVim's way of configuring LSP servers.
    -- This table is merged with LazyVim's default lspconfig options.
    opts = {
      servers = {
        lua_ls = {}, -- Empty table means default setup, LazyVim handles capabilities
        ts_ls = {},
        clangd = {},
        dockerls = {},
        yamlls = {},
        pyright = {},
        neocmake = {},
        tinymist = {}, -- For Typst LSP
        bashls = {},
        marksman = {}, -- For Markdown LSP
        jsonls = {},
        gh_actions_ls = {},
      },
    },
    config = function(_, opts) -- LazyVim passes the opts table to config
      -- Lazily require lspconfig inside the config function
      local lspconfig = require("lspconfig")

      -- Define efmls_config here, where it's accessible for the efm setup
      -- js/ts
      local eslint = require('efmls-configs.linters.eslint')
      -- everything?
      local codespell = require('efmls-configs.linters.codespell')
      local cspell = require('efmls-configs.linters.cspell')
      local prettier = require('efmls-configs.formatters.prettier')
      -- python
      local ruff_linter = require("efmls-configs.linters.ruff")
      local ruff_fmt = require("efmls-configs.formatters.ruff")
      -- lua
      local stylua = require('efmls-configs.formatters.stylua')
      local luacheck = require('efmls-configs.linters.luacheck')
      -- c/c++
      local clang_format = require("efmls-configs.formatters.clang_format")
      local cppcheck = require('efmls-configs.linters.cppcheck')
      clang_format.formatCommand = "clang-format --style=file --fallback-style=LLVM -assume-filename=${INPUT}"
      -- yaml
      local actionlint = require('efmls-configs.linters.actionlint')
      -- markdown
      local markdown_lint = require("efmls-configs.linters.markdownlint")
      -- bash
      local shellcheck = require("efmls-configs.linters.shellcheck")
      local shfmt = require("efmls-configs.formatters.shfmt")
      -- docker
      local docker_lint = require("efmls-configs.linters.hadolint")
      -- cmake 
      local cmake_lint = require("efmls-configs.linters.cmake_lint")
      local cmake_fmt = require('efmls-configs.formatters.gersemi')

      local languages = {
        typescript = { eslint, prettier, cspell, codespell },
        javascript = { eslint, prettier, cspell, codespell },
        json = { prettier, cspell, codespell },
        lua = { stylua, luacheck, cspell, codespell },
        python = { ruff_linter, ruff_fmt, cspell, codespell },
        yaml = { prettier, actionlint, cspell, codespell },
        markdown = { markdown_lint, cspell, codespell},
        cpp = { clang_format, cppcheck, cspell, codespell },
        c = { clang_format, cppcheck, cspell, codespell },
        sh = {shellcheck, shfmt, cspell, codespell },
        dockerfile = { docker_lint, cspell, codespell },
        cmake = { cmake_lint, cmake_fmt, cspell, codespell },
      }

      local efm_lsp_config = {
        filetypes = vim.tbl_keys(languages),
        settings = {
          rootMarkers = { '.git/' },
          languages = languages,
        },
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
        },
      }

      -- Setup the EFM server using lspconfig's setup method
      lspconfig.efm.setup(efm_lsp_config)

      -- Iterate over the servers defined in opts.servers (from LazyVim's opts)
      -- This ensures other LSP servers defined in 'opts.servers' are also set up.
      for server_name, server_opts in pairs(opts.servers) do
        -- Skip efm here, as we just set it up explicitly
        if server_name ~= "efm" then
          local ok, server_setup = pcall(function() return lspconfig[server_name].setup end)
          if ok and type(server_setup) == 'function' then
              server_setup(server_opts)
          else
              -- Handle cases where a server might not exist or setup is not a function
              -- print("Warning: Could not setup LSP server: " .. server_name)
          end
        end
      end
    end,

    -- Keymaps are defined outside of 'opts' and directly in the plugin table.
    -- This is the standard LazyVim way for plugin-specific keymaps.
    keys = {
      -- LSP keymaps
      { "<leader>K", vim.lsp.buf.hover, mode = "n", desc = "Show hover information" },
      { "<leader>gr", "<cmd>FzfLua lsp_references<CR>", desc = "Show LSP references" },
      { "<leader>gd", "<cmd>FzfLua lsp_declarations<CR>", desc = "Go to declaration" },
      { "<leader>gD", "<cmd>FzfLua lsp_definitions<CR>", desc = "Show LSP definitions" },
      { "<leader>gi", "<cmd>FzfLua lsp_implementations<CR>", desc = "Show LSP implementations" },
      { "<leader>gt", "<cmd>FzfLua lsp_typedefs<CR>", desc = "Show LSP type definitions" },
      { "<leader>ga", "<cmd>FzfLua lsp_code_actions<CR>", desc = "Show LSP code actions" },
      -- Add a group leader for CodeCompanion in which-key
      { "<leader>g", "<Nop>", desc = "FzfLSP" },
    },
  },
}
