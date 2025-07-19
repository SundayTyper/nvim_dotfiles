return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy", -- Load codecompanion lazily
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
    },
    keys = {
      { "<leader>ai",  "<Nop>",                             desc = "CodeCompanion" },
      { "<leader>aic", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Launch AI chat" },
      { "<leader>aii", "<cmd>CodeCompanion<CR>",            desc = "Launch AI inline" },
      { "<leader>aia", "<cmd>CodeCompanionActions<CR>",     desc = "Launch AI actions" },
    },
    config = function()
      local ollama_exists = vim.fn.exepath("ollama") ~= ""
      local copilot_exists = os.getenv("copilot_api_key") ~= nil and os.getenv("copilot_api_key") ~= ""

      -- Initialize a table to hold the full configuration
      local opts = {
        adapters = {},
        strategies = {},
        display = {
          chat = {
            show_token_count = false,
            start_in_insert_mode = true,
            show_settings = true,
            window = {
              layout = "float",
            },
            roles = {
              -- The header name for the LLM's messages
              llm = function(adapter)
                return "CodeCompanion (" .. adapter.formatted_name .. ")"
              end,
              -- The header name for your messages
              user = "Me",
            },
          },
          action_palette = {
            width = 95,
            height = 10,
            prompt = "Prompt ",                   -- Prompt used for interactive LLM calls
            provider = "fzf_lua",                 -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks".
            opts = {
              show_default_actions = true,        -- Show the default actions in the action palette?
              show_default_prompt_library = true, -- Show the default prompt library in the action palette?
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
              show_server_tools_in_chat = true,
              add_mcp_prefix_to_tool_names = false,
            },
          },
          vectorcode = {
            ---@type VectorCode.CodeCompanion.ExtensionOpts
            opts = {
              tool_group = {
                -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
                enabled = true,
                -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
                -- if you use @vectorcode_vectorise, it'll be very handy to include
                -- `file_search` here.
                extras = {},
                collapse = false, -- whether the individual tools should be shown in the chat
              },
              tool_opts = {
                ---@type VectorCode.CodeCompanion.ToolOpts
                ["*"] = {},
                ---@type VectorCode.CodeCompanion.LsToolOpts
                ls = {},
                ---@type VectorCode.CodeCompanion.VectoriseToolOpts
                vectorise = {},
                ---@type VectorCode.CodeCompanion.QueryToolOpts
                query = {
                  max_num = { chunk = -1, document = -1 },
                  default_num = { chunk = 50, document = 10 },
                  include_stderr = false,
                  use_lsp = false,
                  no_duplicate = true,
                  chunk_mode = false,
                  ---@type VectorCode.CodeCompanion.SummariseOpts
                  summarise = {
                    ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
                    enabled = false,
                    adapter = nil,
                    query_augmented = true,
                  },
                },
                files_ls = {},
                files_rm = {},
              },
            },
          },
        },
      }

      -- Conditionally add Copilot adapter and set as default strategy if it exists
      if copilot_exists then
        opts.adapters.copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            env = {
              api_key = os.getenv("copilot_api_key"),
            },
          })
        end
        -- Set Copilot as the default for chat and inline if it's the primary choice
        opts.strategies.chat = { adapter = "copilot" }
        opts.strategies.inline = { adapter = "copilot" }
      end

      -- Conditionally add Ollama adapter and potentially override default strategy
      -- if Ollama is preferred or exists alongside Copilot.
      -- If both exist, the later condition will set the strategies.
      if ollama_exists then
        opts.adapters.ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              num_ctx = {
                default = 4096,
              },
              temperature = {
                default = 0.2,
              },
              top_p = {
                default = 0.9,
              },
              num_gpu = {
                default = -1,
              },
            },
          })
        end
        -- Set Ollama as the default for chat and inline if it's the primary choice or
        -- if you want it to override Copilot when both are present.
        opts.strategies.chat = {
          adapter = {
            name = "ollama",
            model = "qwen2.5-coder:latest",
          },
        }
        opts.strategies.inline = {
          adapter = {
            name = "ollama",
            model = "qwen2.5-coder:latest",
          },
        }
      end

      -- Call setup once with the complete configuration table
      require("codecompanion").setup(opts)

      -- Fidget integration
      local progress = require("fidget.progress")
      local handles = {}
      local group = vim.api.nvim_create_augroup("CodeCompanionFidget", { clear = true }) -- Add clear = true to prevent duplicate autocmds on reload

      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeCompanionRequestStarted",
        group = group,
        callback = function(e)
          handles[e.data.id] = progress.handle.create({
            title = "CodeCompanion",
            message = "Thinking...",
            lsp_client = { name = e.data.adapter.formatted_name },
          })
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeCompanionRequestCompleted,CodeCompanionRequestFailed",
        group = group,
        callback = function(e)
          if handles[e.data.id] then
            handles[e.data.id]:finish()
            handles[e.data.id] = nil
          end
        end,
      })
    end,
  },
}
