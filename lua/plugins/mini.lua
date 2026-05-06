local M = {}

M.packages = {
  {
    src = "https://github.com/echasnovski/mini.diff.git",
    name = "mini.diff",
  },
  {
    src = "https://github.com/echasnovski/mini.comment.git",
    name = "mini.comment",
  },
  {
    src = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring.git",
    name = "nvim-ts-context-commentstring",
  },
  {
    src = "https://github.com/echasnovski/mini.icons.git",
    name = "mini.icons",
  },
  {
    src = "https://github.com/echasnovski/mini.pairs.git",
    name = "mini.pairs",
    version = vim.version.range("*"),
  },
}

--- Loads and configures the mini.nvim modules used across the editor.
function M.setup()
  vim.cmd("packadd mini.icons")
  require("mini.icons").setup({
    file = {
      [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
      ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
    },
    filetype = {
      dotenv = { glyph = "", hl = "MiniIconsYellow" },
    },
  })

  --- Exposes mini.icons as a drop-in nvim-web-devicons provider for dependent plugins.
  package.preload["nvim-web-devicons"] = function()
    require("mini.icons").mock_nvim_web_devicons()
    return package.loaded["nvim-web-devicons"]
  end

  vim.cmd("packadd nvim-ts-context-commentstring")
  require("ts_context_commentstring").setup({
    enable_autocmd = false,
  })

  vim.cmd("packadd mini.comment")
  require("mini.comment").setup({
    options = {
      custom_commentstring = function()
        return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
      end,
    },
  })

  vim.cmd("packadd mini.diff")
  require("mini.diff").setup({
    view = {
      style = "sign",
      signs = {
        add = "▎",
        change = "▎",
        delete = "",
      },
    },
  })

  vim.keymap.set("n", "<leader>go", function()
    require("mini.diff").toggle_overlay(0)
  end, { desc = "Toggle mini.diff overlay" })

  vim.cmd("packadd mini.pairs")
  require("mini.pairs").setup({
    pairs = {
      map = {
        ["("] = { close = ")", action = "both" },
        ["["] = { close = "]", action = "both" },
        ["{"] = { close = "}", action = "both" },
        ['"'] = { close = '"', action = "both", pair_break = { enable = true, next = true } },
        ["'"] = { close = "'", action = "both", pair_break = { enable = true, next = true } },
      },
    },
  })
end

return M
