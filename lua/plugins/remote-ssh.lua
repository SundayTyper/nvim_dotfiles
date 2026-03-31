:return {
  {
    "inhesrom/remote-ssh.nvim",
    branch = "master",
    dependencies = {
      "inhesrom/telescope-remote-buffer",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      "rcarriga/nvim-notify",
    },
    cmd = {
      "RemoteOpen",
      "RemoteTreeBrowser",
      "RemoteSession",
      "RemoteSessionPicker",
      "RemoteTerminalNew",
      "RemoteTui",
      "RemoteSSHLog",
      "RemoteDependencyCheck",
    },
    config = function()
      require("telescope-remote-buffer").setup()
      require("remote-ssh").setup({})
    end,
  },
}