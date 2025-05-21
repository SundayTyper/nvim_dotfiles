return {
  {
  'creativenull/efmls-configs-nvim',
  event = { "BufReadPre", "BufNewFile" },
  lazy = true,
  version = '', -- version latest
  dependencies = { 'neovim/nvim-lspconfig' },
  config = function()
    -- Register linters and formatters per language
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


    local efmls_config = {
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

    require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {
    -- Pass your custom lsp config below like on_attach and capabilities
    --
    -- on_attach = on_attach,
    -- capabilities = capabilities,
    }))
  end,
  },
}
