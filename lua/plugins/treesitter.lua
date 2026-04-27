local M = {}

local parsers = {
  -- Languages with LSP support
  "bash",
  "c",
  "cpp",
  "cmake",
  "dockerfile",
  "javascript",
  "typescript",
  "tsx",
  "json",
  "jsonc",
  "clojure",
  "fennel",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "racket",
  "scheme",
  "yaml",
  "typst",

  -- Supporting languages
  "vim",
  "vimdoc",
  "query",
  "regex",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "html",
  "css",
}

M.packages = {
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter.git",
    name = "nvim-treesitter",
  },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-context.git",
    name = "nvim-treesitter-context",
  },
}

M.build_hooks = {
  ["nvim-treesitter"] = ":TSInstallSync " .. table.concat(parsers, " ") .. " | TSUpdateSync",
}

function M.setup()
  vim.cmd("packadd nvim-treesitter")
  require("nvim-treesitter.configs").setup({
  -- Archived upstream: keep installs explicit and update parsers manually via :TSUpdate.
      ensure_installed = {},
      
      -- Enable tree-sitter-based indentation
      indent = {
        enable = true,
        -- Disable for languages where it causes issues
        disable = { "python" }, -- Python indentation is better handled by LSP
      },
      
      -- Incremental selection based on treesitter
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<S-CR>",
          node_decremental = "<BS>",
        },
      },
      
      -- Required fields
      modules = {},
      ignore_install = {},
      sync_install = false,
      auto_install = false,
      
      -- Syntax highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })

  vim.cmd("packadd nvim-treesitter-context")
  require("treesitter-context").setup({
    line_numbers = false,
    max_lines = 3,
    min_window_height = 12,
    mode = "topline",
    multiline_threshold = 4,
    separator = "-",
  })
end

return M
