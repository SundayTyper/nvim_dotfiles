return {
  {
    "olimorris/codecompanion.nvim",
    cond = function()
      local ollama_exists = vim.fn.exepath("ollama") ~= ""
      if not ollama_exists then
        vim.notify(
          "Ollama executable not found. Skipping CodeCompanion plugin.",
          vim.log.levels.WARN,
          { title = "Plugin Load Warning" }
        )
      end
      return ollama_exists
    end,
    event = "VeryLazy", -- Load codecompanion lazily
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "ravitemer/mcphub.nvim", build = "npm install -g mcp-hub@latest" },
    },
    keys = {
      { "<leader>a",  "<Nop>",                      desc = "CodeCompanion" },
      { "<leader>ai", "<cmd>CodeCompanionChat<CR>", desc = "Launch AI chat" },
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "ollama",
            model = "qwen2.5-coder",
            roles = {
              ---The header name for the LLM's messages
              llm = function(adapter)
                return "CodeCompanion (" .. adapter.formatted_name .. ")"
              end,

              ---The header name for your messages
              user = "Me",
            },
          },
        },
        display = {
          chat = {
            show_token_count = false,
            start_in_insert_mode = true,

            window = {
              layout = "float",
            },
          },
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true,
            },
          },
        },
      })
    end,
  },
}
