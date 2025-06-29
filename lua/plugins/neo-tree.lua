return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    keys = {
      { "<Leader>e", "<cmd>Neotree toggle<cr>", desc = "Show file tree" },
      { "<Leader>E", "<cmd>Neotree focus<cr>", desc = "Focus file tree" },
    },
    opts = {
      close_if_last_wndow = true,
    },
  },
  { "MunifTanjim/nui.nvim", lazy = true },
}
