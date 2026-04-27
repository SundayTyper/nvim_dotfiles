local M = {}

M.packages = {
  {
    src = "https://github.com/rafamadriz/friendly-snippets.git",
    name = "friendly-snippets",
  },
  {
    src = "https://github.com/saghen/blink.cmp.git",
    name = "blink.cmp",
    version = vim.version.range("0"),
  },
}

function M.setup()
  vim.cmd("packadd friendly-snippets")
  vim.cmd("packadd blink.cmp")

  require("blink.cmp").setup({
    keymap = {
      preset = "default",
      ["<C-n>"] = { "select_next" },
      ["<Up>"] = {},
      ["<Down>"] = {},
      ["<C-p>"] = {},
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      list = {
        selection = { preselect = false, auto_insert = false },
      },
      ghost_text = {
        enabled = true,
      },
    },
    signature = { enabled = true },
    sources = {
      default = { "lsp", "buffer", "snippets", "path", "omni" },
    },
  })
end

return M
