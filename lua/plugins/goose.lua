local M = {}

M.packages = {
  {
    src = "https://github.com/nvim-lua/plenary.nvim.git",
    name = "plenary.nvim",
  },
  {
    src = "https://github.com/azorng/goose.nvim.git",
    name = "goose.nvim",
  },
}

function M.setup()
  vim.cmd("packadd plenary.nvim")
  vim.cmd("packadd goose.nvim")

  require("goose").setup({
    prefered_picker = "fzf",
    default_global_keymaps = false,
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

  vim.keymap.set("n", "<leader>a", "<nop>", { desc = "+ai" })
  vim.keymap.set("n", "<leader>ag", "<cmd>Goose<cr>", { desc = "Toggle Goose" })
  vim.keymap.set("n", "<leader>ai", "<cmd>GooseOpenInput<cr>", { desc = "Open Input" })
  vim.keymap.set("n", "<leader>aI", "<cmd>GooseOpenInputNewSession<cr>", { desc = "Open Input (New Session)" })
  vim.keymap.set("n", "<leader>ao", "<cmd>GooseOpenOutput<cr>", { desc = "Open Output" })
  vim.keymap.set("n", "<leader>at", "<cmd>GooseToggleFocus<cr>", { desc = "Toggle Focus" })
  vim.keymap.set("n", "<leader>aq", "<cmd>GooseClose<cr>", { desc = "Close Goose" })
  vim.keymap.set("n", "<leader>af", "<cmd>GooseToggleFullscreen<cr>", { desc = "Toggle Fullscreen" })
  vim.keymap.set("n", "<leader>as", "<cmd>GooseSelectSession<cr>", { desc = "Select Session" })
  vim.keymap.set("n", "<leader>am", "<nop>", { desc = "+mode" })
  vim.keymap.set("n", "<leader>amc", "<cmd>GooseModeChat<cr>", { desc = "Chat Mode" })
  vim.keymap.set("n", "<leader>ama", "<cmd>GooseModeAuto<cr>", { desc = "Auto Mode" })
  vim.keymap.set("n", "<leader>ap", "<cmd>GooseConfigureProvider<cr>", { desc = "Configure Provider" })
  vim.keymap.set("n", "<leader>a.", "<cmd>GooseOpenConfig<cr>", { desc = "Open Config" })
  vim.keymap.set("n", "<leader>a?", "<cmd>GooseInspectSession<cr>", { desc = "Inspect Session" })
  vim.keymap.set("n", "<leader>ad", "<cmd>GooseDiff<cr>", { desc = "Show Diff" })
  vim.keymap.set("n", "<leader>a]", "<cmd>GooseDiffNext<cr>", { desc = "Next Diff" })
  vim.keymap.set("n", "<leader>a[", "<cmd>GooseDiffPrev<cr>", { desc = "Prev Diff" })
  vim.keymap.set("n", "<leader>ac", "<cmd>GooseDiffClose<cr>", { desc = "Close Diff" })
  vim.keymap.set("n", "<leader>ar", "<nop>", { desc = "+revert" })
  vim.keymap.set("n", "<leader>ara", "<cmd>GooseRevertAll<cr>", { desc = "Revert All Changes" })
  vim.keymap.set("n", "<leader>art", "<cmd>GooseRevertThis<cr>", { desc = "Revert This File" })
end

return M
