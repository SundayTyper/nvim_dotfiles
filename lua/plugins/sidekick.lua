-- Sidekick.nvim - AI assistant with Next Edit Suggestions and CLI integration
return {
  {
    "folke/sidekick.nvim",
    dependencies = {
      "folke/snacks.nvim", -- Already installed
      "nvim-treesitter/nvim-treesitter", -- Already installed
    },
    lazy = true,
    opts = {
      -- Enable CLI with tmux/zellij for persistent sessions
      cli = {
        mux = {
          enabled = true,
          backend = "tmux", -- Change to "zellij" if you prefer
        },
        -- Set OpenCode as the default AI CLI tool
        default = "opencode",
      },
    },
    keys = {
      -- AI Assistant category
      { "<leader>a", "<noop>", desc = "+ai" },
      
      -- Next Edit Suggestions navigation
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      
      -- CLI Toggle shortcuts
      {
        "<c-.>",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select()
        end,
        desc = "Select CLI Tool",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach CLI Session",
      },
      
      -- Send context to AI
      {
        "<leader>at",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This to AI",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File to AI",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send Visual Selection to AI",
      },
      
      -- Prompt selection
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      
      -- NES commands
      {
        "<leader>an",
        function()
          require("sidekick.nes").toggle()
        end,
        desc = "Toggle Next Edit Suggestions",
      },
      {
        "<leader>au",
        function()
          require("sidekick.nes").update()
        end,
        desc = "Update Next Edit Suggestions",
      },
      {
        "<leader>ac",
        function()
          require("sidekick.nes").clear()
        end,
        desc = "Clear Next Edit Suggestions",
      },
    },
  },
}
