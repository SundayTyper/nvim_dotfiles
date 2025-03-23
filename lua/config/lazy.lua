require("lazy").setup({
  spec = {
    -- { "LazyVim/LazyVim", import = "lazyvim.plugins" }, -- lazyvim plugins
    { import = "plugins" }, -- Your custom plugins
    { import = "config.theme" }, -- Your theme configuration
  },
  defaults = {
    lazy = false,
    version = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
})
