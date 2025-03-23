return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      -- Add your configuration here
      -- Example:
      window = {
        mappings = {
          ["<space>"] = "toggle_node",
        },
      },
      keys = {
	          {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
      end,
      desc = "Explorer NeoTree (Root Dir)",
    },
        {
      "<leader>b",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true })
      end,
      desc = "Buffer Explorer",
    },
    },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {
            ".DS_Store",
            "thumbs.db",
            "node_modules",
          },
          hide_by_pattern = {
            "*.meta",
            "*/.git/*",
            "*/target/*",
          },
          always_show = {},
          never_show = {},
          never_show_by_pattern = {},
        },
      },
    })

    vim.keymap.set("n", "<leader>e", function()
      local root_dir = vim.fn.getcwd() -- Get the current working directory
      require("neo-tree").open({ dir = root_dir, position = "left" })
    end, { desc = "Open Neo-tree in root" })
  end,
}
