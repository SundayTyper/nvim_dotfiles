-- Goose.nvim - AI assistant with persistent sessions and streaming responses

return {
  {
    "azorng/goose.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
      "folke/snacks.nvim",
    },
    config = function()
      require("goose").setup({
        prefered_picker = "snacks",
        default_global_keymaps = true,
        
        keymap = {
          global = {
            toggle = "<leader>ag",
            open_input = "<leader>ai",
            open_input_new_session = "<leader>aI",
            open_output = "<leader>ao",
            toggle_focus = "<leader>at",
            close = "<leader>aq",
            toggle_fullscreen = "<leader>af",
            select_session = "<leader>as",
            goose_mode_chat = "<leader>amc",
            goose_mode_auto = "<leader>ama",
            configure_provider = "<leader>ap",
            open_config = "<leader>a.",
            inspect_session = "<leader>a?",
            diff_open = "<leader>ad",
            diff_next = "<leader>a]",
            diff_prev = "<leader>a[",
            diff_close = "<leader>ac",
            diff_revert_all = "<leader>ara",
            diff_revert_this = "<leader>art",
          },
          window = {
            submit = "<cr>",
            submit_insert = "<cr>",
            close = "<esc>",
            stop = "<C-c>",
            next_message = "]]",
            prev_message = "[[",
            mention_file = "@",
            toggle_pane = "<tab>",
            prev_prompt_history = "<up>",
            next_prompt_history = "<down>",
          },
        },
        
        ui = {
          window_type = "float",
          window_width = 0.35,
          input_height = 0.15,
          fullscreen = false,
          layout = "right",
          floating_height = 0.8,
          display_model = true,
          display_goose_mode = false,
        },
        
        providers = {
          ollama = {
            "qwen3-coder-next",
          },
        },
        
        system_instructions = "",
      })
    end,
    
    keys = {
      { "<leader>a", "<noop>", desc = "+ai" },
      { "<leader>ag", "<cmd>Goose<cr>", desc = "Toggle Goose" },
      { "<leader>ai", "<cmd>GooseOpenInput<cr>", desc = "Open Input" },
      { "<leader>aI", "<cmd>GooseOpenInputNewSession<cr>", desc = "Open Input (New Session)" },
      { "<leader>ao", "<cmd>GooseOpenOutput<cr>", desc = "Open Output" },
      { "<leader>at", "<cmd>GooseToggleFocus<cr>", desc = "Toggle Focus" },
      { "<leader>aq", "<cmd>GooseClose<cr>", desc = "Close Goose" },
      { "<leader>af", "<cmd>GooseToggleFullscreen<cr>", desc = "Toggle Fullscreen" },
      { "<leader>as", "<cmd>GooseSelectSession<cr>", desc = "Select Session" },
      { "<leader>amc", "<cmd>GooseModeChat<cr>", desc = "Chat Mode" },
      { "<leader>ama", "<cmd>GooseModeAuto<cr>", desc = "Auto Mode" },
      { "<leader>ap", "<cmd>GooseConfigureProvider<cr>", desc = "Configure Provider" },
      { "<leader>a.", "<cmd>GooseOpenConfig<cr>", desc = "Open Config" },
      { "<leader>a?", "<cmd>GooseInspectSession<cr>", desc = "Inspect Session" },
      { "<leader>ad", "<cmd>GooseDiff<cr>", desc = "Show Diff" },
      { "<leader>a]", "<cmd>GooseDiffNext<cr>", desc = "Next Diff" },
      { "<leader>a[", "<cmd>GooseDiffPrev<cr>", desc = "Prev Diff" },
      { "<leader>ac", "<cmd>GooseDiffClose<cr>", desc = "Close Diff" },
      { "<leader>ara", "<cmd>GooseRevertAll<cr>", desc = "Revert All Changes" },
      { "<leader>art", "<cmd>GooseRevertThis<cr>", desc = "Revert This File" },
    },
  },
}
