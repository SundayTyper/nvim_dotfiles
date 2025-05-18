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
      { "<Leader>e", "<cmd>Neotree filesystem reveal left<cr>", desc = "Show file tree" },
      { "<Leader>E", "<cmd>Neotree filesystem close<cr>", desc = "Show file tree" },
    },
    opts = {
      -- fill any relevant options here
    },
  },
  { "MunifTanjim/nui.nvim", lazy = true },
}
