-- blink-completion.lua
return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    opts = {
      keymap = {
        preset = "default",
        -- Custom key mappings
        ["<C-Up>"] = { "select_next" },
        ["<C-Down>"] = { "select_prev" },
        ["<C-CR>"] = { "accept" },
        -- Disable key maps that I don't like
        ["<Up>"] = {},
        ["<Down>"] = {},
        ["<C-p>"] = {},
        ["<C-n>"] = {},
      },
      completion = {
        list = {
          selection = { preselect = false, auto_insert = false }, -- set to preselect, manual or auto_insert
        },
        ghost_text = {
          enabled = true,
        },
      },
      signature = { enabled = true },
    },
  },
}
