-- Snacks.nvim - Collection of QoL plugins by folke

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Disable features that overlap with existing plugins
      terminal = { enabled = false },
      notifier = { enabled = false },
      indent = { enabled = true }, -- Replacing blink.indent due to v2.0.0 loading errors
      gitbrowse = { enabled = false },

      -- Enable picker for file/buffer searching
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
      },

      -- Enable dashboard with custom config
      dashboard = {
        enabled = true,
        preset = {
          header = [[
	 _____    _        _   _ _
	|  ___|  | |      | | | (_)
	| |__  __| |______| | | |_ _ __ ___
	|  __|/ _` |______| | | | | '_ ` _ \
	| |__| (_| |      \ \_/ / | | | | | |
	\____/\__,_|       \___/|_|_| |_| |_|
          ]],
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },

      -- Enable non-overlapping features
      bigfile = { enabled = true }, -- Disable features for large files
      quickfile = { enabled = true }, -- Quick file operations
      statuscolumn = { enabled = true }, -- Enhanced statuscolumn
      words = { enabled = true }, -- Highlight word under cursor

      -- Git integration (complements mini.diff)
      git = {
        enabled = true,
        -- Timeout for git commands
        timeout = 5000,
      },

      -- Scope highlighting
      scope = {
        enabled = true,
      },

      -- Scrollbar
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 150 },
        },
      },

      -- Zen mode
      zen = {
        enabled = true,
        toggles = {
          dim = true,
          git_signs = false,
          mini_diff_signs = false,
        },
      },

      -- Animations (subtle, performance-friendly)
      animate = {
        enabled = true,
        fps = 60,
        easing = "linear",
      },

      -- Dim inactive windows
      dim = {
        enabled = true,
      },

      -- Input popup
      input = {
        enabled = true,
      },

      -- Scratch buffer
      scratch = {
        enabled = true,
      },

      -- Toggle terminal alternative keybinds
      toggle = {
        enabled = true,
      },

      -- Rename (enhanced rename UI)
      rename = {
        enabled = true,
      },

      -- Profiler
      profiler = {
        enabled = true,
      },

      -- Debug
      debug = {
        enabled = true,
      },

      -- Lazygit
      lazygit = {
        enabled = true,
        configure = true,
      },
    },

    keys = {
      -- Picker (File/Buffer Navigation)
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Live Grep",
      },
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>fh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help Tags",
      },
      {
        "<leader>fo",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent Files",
      },
      {
        "<leader>fc",
        function()
          Snacks.picker.commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>fk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>fm",
        function()
          Snacks.picker.marks()
        end,
        desc = "Marks",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume Last",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Search Word Under Cursor",
      },
      {
        "<leader>sb",
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = "Grep Current Buffer",
      },

      -- Git
      {
        "<leader>gb",
        function()
          Snacks.git.blame_line()
        end,
        desc = "Git Blame Line",
      },

      -- Scratch buffer
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },

      -- Zen mode
      {
        "<leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>Z",
        function()
          Snacks.zen.zoom()
        end,
        desc = "Toggle Zoom",
      },

      -- Rename
      {
        "<leader>cr",
        function()
          Snacks.rename.rename_file()
        end,
        desc = "Rename File",
      },

      -- Debug/Profile
      {
        "<leader>ps",
        function()
          Snacks.profiler.scratch()
        end,
        desc = "Profiler Scratch",
      },

      -- Lazygit
      {
        "<leader>lg",
        function()
          Snacks.lazygit.open()
        end,
        desc = "Lazygit",
      },
    },

    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for easier access
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks.debug
        end,
      })
    end,
  },
}
