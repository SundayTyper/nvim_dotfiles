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
        ["<Tab>"] = { "select_next" },
        ["<S-Tab>"] = { "select_prev" },
        ["<S-CR>"] = { "accept" },
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
