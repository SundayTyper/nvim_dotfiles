return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      -- autocomplete suggestions
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
      -- configure docker lsp
      lspconfig["dockerls"].setup({
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
      lspconfig["neocmake"].setup({
        capabilities = capabilities,
      })
      -- configure typst lsp
      lspconfig["tinymist"].setup({
        capabilities = capabilities,
      })
      -- configure bash lsp
      lspconfig["bashla"].setup({
        capabilities = capabilities,
      })
      -- configure yaml lsp
      lspconfig["yamlls"].setup({
        capabilities = capabilities,
      })
      -- configure markdown lsp
      lspconfig["marksman"].setup({
        capabilities = capabilities,
      })
      -- configure json lsp
      lspconfig["jsonls"].setup({
        capabilities = capabilities,
      })
      -- configure gh_actions lsp
      lspconfig["gh_actions_ls"].setup({
        capabilities = capabilities,
      })
      
    end,

    opts = {
      keymap = {
        { "<leader>gr", "<cmd>FzfLua lsp_references<CR>", desc = "Show LSP references" },
        { "<leader>gd", "<cmd>FzfLua lsp_declarations<CR>", desc = "Go to declaration" },
        { "<leader>gD", "<cmd>FzfLua lsp_definitions<CR>", desc = "Show LSP definitions" },
        { "<leader>gi", "<cmd>FzfLua lsp_implementations<CR>", desc = "Show LSP implementations" },
        { "<leader>gt", "<cmd>FzfLua lsp_typedefs<CR>", desc = "Show LSP type definitions" },
        { "<leader>ga", "<cmd>FzfLua lsp_code_actions<CR>", desc = "Show LSP code actions" },
        { "K", vim.lsp.buf.hover, mode = "n", desc = "Show hover information" },
      },
    },
  },
}
