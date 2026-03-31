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
        ["<C-n>"] = { "select_next" },
        -- Disable key maps that I don't like
        ["<Up>"] = {},
        ["<Down>"] = {},
        ["<C-p>"] = {},
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        list = {
          -- set to preselect, manual or auto_insert
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
    },
  },
}
