local M = {}

M.packages = {
  {
    src = "https://github.com/folke/snacks.nvim.git",
    name = "snacks.nvim",
  },
}

function M.setup()
  vim.cmd("packadd snacks.nvim")

  require("snacks").setup({
      -- Disable features that overlap with existing plugins
      terminal = { enabled = false },
      notifier = { enabled = false },
      indent = { enabled = true }, -- Replacing blink.indent due to v2.0.0 loading errors
      gitbrowse = { enabled = false },
      picker = { enabled = false },

      -- Enable dashboard with custom config
      dashboard = {
        enabled = true,
        preset = {
          header = [[
          .-"""""""-.
        .'       __  \_
       /        /  \/  \
      |         \_0/\_0/______
      |:.          .'       oo`\
      |:.         /             \
      |' ;        |             |
      |:..   .     \_______     |
      |::.|'     ,  \,_____\   /
      |:::.; ' | .  '|      )_/
      |::; | | ; ; | |
     /::::.|-| |_|-|, \
    /'-=-'`  '-'   '--'\
        ]],
        center = {},
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
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

      lazygit = { enabled = false },
    })

  _G.dd = function(...)
    Snacks.debug.inspect(...)
  end
  _G.bt = function()
    Snacks.debug.backtrace()
  end
  vim.print = _G.dd

  vim.keymap.set("n", "<leader>g", "<nop>", { desc = "+git" })
  vim.keymap.set("n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })
  vim.keymap.set("n", "<leader>l", "<nop>", { desc = "+lsp" })
  vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP Info" })
  vim.keymap.set("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
  vim.keymap.set("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })
  vim.keymap.set("n", "<leader>d", "<nop>", { desc = "+debug" })
  vim.keymap.set("n", "<leader>ds", function() Snacks.profiler.scratch() end, { desc = "Profiler Scratch" })
  vim.keymap.set("n", "<leader>z", "<nop>", { desc = "+zen" })
  vim.keymap.set("n", "<leader>zz", function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
  vim.keymap.set("n", "<leader>zm", function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
  vim.keymap.set("n", "<leader>b", "<nop>", { desc = "+buffer" })
  vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
  vim.keymap.set({ "n", "v" }, "<leader>c", "<nop>", { desc = "+code" })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
  vim.keymap.set("n", "<leader>cr", function() Snacks.rename() end, { desc = "Rename Symbol" })
end

return M
