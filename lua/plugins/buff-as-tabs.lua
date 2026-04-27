local M = {}

M.packages = {
  {
    src = "https://github.com/akinsho/bufferline.nvim.git",
    name = "bufferline.nvim",
  },
  {
    src = "https://github.com/nvim-tree/nvim-web-devicons.git",
    name = "nvim-web-devicons",
  },
}

function M.setup()
  vim.cmd("packadd nvim-web-devicons")
  vim.cmd("packadd bufferline.nvim")

  require("bufferline").setup({
    options = {
      mode = "buffers",
      close_button = "x",
      show_buffer_close_icons = false,
      show_close_icon = true,
      right_mouse_command = "bdelete! %d",
      diagnostics = "nvim_lsp",
      icon_custom_colors = true,
      always_show_bufferline = true,
      sort_by = "id",
      separator_style = "slant",
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  })

  vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
  vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
  vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
  vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
end

return M
