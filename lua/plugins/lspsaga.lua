-- File: lua/plugins/lspsaga.lua

return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach", -- Load when any LSP attaches
  dependencies = {
    -- Required for icons and better UI
    "nvim-tree/nvim-web-devicons",
    -- Fidget is optional but highly recommended for status
    "j-hui/fidget.nvim",
  },

  -- The 'opts' function handles the core configuration
  opts = {
    -- Configuration for the code action menu
    code_action = {
      -- Use 'p' to select the previous item, 'n' for next
      quit = "q",
      exec = "<CR>",
    },

    -- Configuration for the rename dialog
    rename = {
      quit = "<C-c>",
      submit = "<CR>",
    },

    -- Configuration for the peek/finder windows (References, Definition)
    finder = {
      keys = {
        quit = "q",
        toggle_preview = "p",
      },
    },

    -- Configuration for diagnostics sidebar
    diagnostic = {
      show_all_diagnostics = true,
      -- Maps for navigating diagnostics in the saga window
      keys = {
        quit_preview = "q",
        jump_to_owner = "o",
      },
    },
  },

  keys = {
      { "gD", "<cmd>Lspsaga definition<CR>", desc = "Go to definition" },
      { "gd", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek definition" },
      { "gr", "<cmd>Lspsaga references<CR>", desc = "Find references" },

      { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover documentation" },

      { "[d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
      { "]d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous Diagnostic" },
      { "<leader>pd", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show line Diagnostics" },

      { "<leader>ca", "<cmd>Lspsaga code_action<CR>", desc = "Code action" },
      { "<leader>rn", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
  },
}
