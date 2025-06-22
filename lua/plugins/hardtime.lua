return {
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = "MunifTanjim/nui.nvim",
     opts = {
      disabled_keys = {
        ["<Up>"] = { "n", "x" },
        ["<Down>"] = { "n", "x" },
        ["<Left>"] = { "n", "x" },
        ["<Right>"] = { "n", "x" },
      },
    },
    keys = {
      -- LSP keymaps
      { "<leader>ht", "<cmd>Hardtime toggle<CR>", mode = "n", desc = "Toggle HardTime" },
    },
  },
}
