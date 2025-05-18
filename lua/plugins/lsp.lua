return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- configure lua lsp
      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
      })
      -- configure typscript lsp
      lspconfig["ts_ls"].setup({
        capabilities = capabilities,
      })
      -- configure clangd lsp
      lspconfig["clangd"].setup({
        capabilities = capabilities,
      })
      -- configure yaml lsp
      lspconfig["yamlls"].setup({
        capabilities = capabilities,
      })
      -- configure python lsp
      lspconfig["pyright"].setup({
        capabilities = capabilities,
      })
      -- configure cmake lsp
      lspconfig["cmakelang"].setup({
        capabilities = capabilities,
      })
      -- configure typst lsp
      lspconfig["tinymist"].setup({
        capabilities = capabilities,
      })
    end,

    opts = {
      keymap = {
        { "<leader>gd", "<cmd>FzfLua lsp_regerences<CR>", desc = "Show LSP references" },
        { "<leader>gd", "<cmd>FzfLua lsp_declarations<CR>", desc = "Go to declaration" },
        { "<leader>gd", "<cmd>FzfLua lsp_definitions<CR>", desc = "Show LSP definitions" },
        { "<leader>gd", "<cmd>FzfLua lsp_implementations<CR>", desc = "Show LSP implementations" },
        { "<leader>gd", "<cmd>FzfLua lsp_typedefs<CR>", desc = "Show LSP type definitions" },
        { "<leader>gd", "<cmd>FzfLua lsp_code_actions<CR>", desc = "Show LSP code actions" },
        { "K", vim.lsp.buf.hover, mode = "n", desc = "Show hover information" },
      },
    },
  },
}
