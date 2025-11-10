-- Tree-sitter configuration for syntax highlighting
-- Parsers aligned with LSP servers configuration
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = 'master',
    opts = {
      -- Ensure these parsers match our LSP servers
      ensure_installed = {
        -- Languages with LSP support
        "bash",              -- bashls
        "c",                 -- clangd
        "cpp",               -- clangd
        "cmake",             -- neocmake
        "dockerfile",        -- dockerls
        "javascript",        -- ts_ls
        "typescript",        -- ts_ls
        "tsx",               -- ts_ls
        "json",              -- jsonls
        "jsonc",             -- jsonls
        "lua",               -- lua_ls
        "markdown",          -- marksman
        "markdown_inline",   -- marksman
        "python",            -- pyright, ruff
        "yaml",              -- yamlls, gh_actions_ls
        "typst",             -- tinymist
        
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
      },
      
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
      auto_install = true,
      
      -- Syntax highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
}
