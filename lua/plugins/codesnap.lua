return {
  {
    "mistricky/codesnap.nvim",
    build = "make",
    keys = {
      { "<leader>cc", "<cmd>CodeSnap<cr>",      mode = "x", desc = "Save selected code snapshot into clipboard" },
      { "<leader>ca", "<cmd>CodeSnapASCII<cr>", mode = "x", desc = "Save selected code into clipboard" },
      { "<leader>cs", "<cmd>CodeSnapSave<cr>",  mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
      { "<leader>c",  "<Nop>",                  mode = "x", desc = "Codesnap prefix" },
    },
    opts = {
      mac_window_bar = true,
      title = "",
      code_font_family = "CaskaydiaCove Nerd Font",
      watermark_font_family = "Pacifico",
      watermark = "",
      bg_theme = "#535c68",
      breadcrumbs_separator = "/",
      has_breadcrumbs = true,
      has_line_number = false,
      show_workspace = false,
      min_width = 0,
      bg_x_padding = 122,
      bg_y_padding = 82,
      save_path = os.getenv("XDG_PICTURES_DIR") or (os.getenv("HOME") .. "/Pictures"),
    },
  },
}
