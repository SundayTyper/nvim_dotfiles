-- This file configures wsdjeg/flygrep.nvim for live text searching.

return {
  "wsdjeg/flygrep.nvim",
  -- Flygrep requires 'wsdjeg/job.nvim' as a dependency for async operations.
  dependencies = { "wsdjeg/job.nvim" },
  -- Load it lazily based on the command it provides.
  cmd = "FlyGrep",
  opts = {
    -- You can customize flygrep's behavior here.
    -- These are some common options, refer to flygrep's documentation for more.

    -- Default command to use for searching (ripgrep 'rg' is highly recommended)
    -- Ensure ripgrep is installed on your system.
    command = {
      execute = "rg",
      default_opts = {
        "--no-heading",
        "--color=never",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case", -- case-insensitive unless pattern contains uppercase
        "--hidden",     -- include hidden files/directories
        -- "--follow",     -- follow symlinks (uncomment if desired)
        -- "--glob",       -- include/exclude files based on glob patterns (e.g., {"!**/.git/*"})
      },
    },
    -- Timeout for the search in milliseconds.
    timeout = 300,
    -- Color template for the search results (customize as desired)
    color_templete = {
      a = { fg = "#2c323c", bg = "#98c379", ctermfg = 16, ctermbg = 114, bold = true },
      b = { fg = "#abb2bf", bg = "#3b4048", ctermfg = 145, ctermbg = 16, bold = false },
    },
    -- Window options for the floating window
    win_opts = {
      relative = "editor",
      width = 0.8,
      height = 0.8,
      row = 0.1,
      col = 0.1,
      border = "rounded", -- 'rounded', 'single', 'double', 'none'
      -- You can also set specific highlight groups for the border
      -- border_highlight = "FloatBorder",
      -- Other options like `focusable`, `noautocmd`, etc.
    },
    -- Whether to automatically open the quickfix list when FlyGrep finishes.
    auto_open_qflist = false,
  },
  -- Define your keymaps here.
  -- LazyVim will automatically integrate these with which-key.nvim.
  keys = {
    {
      "<leader>ff",
      function()
        -- You can call flygrep.open() with options, or just the command for default behavior.
        -- To search in the current working directory:
        require("flygrep").open({ cwd = vim.fn.getcwd() })

        -- To search for the word under the cursor:
        -- require("flygrep").open({ input = vim.fn.expand("<cword>") })

        -- To search in the current buffer's directory:
        -- require("flygrep").open({ cwd = vim.fn.fnamemodify(vim.fn.bufname(), ":p:h") })
      end,
      mode = "n",
      desc = "FlyGrep Search Files", -- This description appears in which-key
    },
  },
}
