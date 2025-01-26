-- blink-completion.lua
return {
  {
    "Saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    opts = {
      keymap = {
        preset = "default",
        -- Custom key mappings
        ["<Tab>"] = { "select_next" },
        ["<S-Tab>"] = { "select_prev" },
        ["<S-CR>"] = { "accept" },
      },
      completion = {
        list = {
          selection = "manual", -- set to preselect, manual or auto_insert
          --   preselect = false,
          --   auto_insert = false,
          -- },
        },
        ghost_text = {
          enabled = false,
        },
      },
      signature = { enabled = true },
    },
  },
}
