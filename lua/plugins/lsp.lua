return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghan/blink.cmp",
      "folke/lazydev.nvim",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Lua LSP setup
      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
        ft = { "lua" },
      })

      -- C/C++ LSP setup
      require("lspconfig").clangd.setup({
        capabilities = capabilities,
        ft = { "c", "cpp" },
      })

      -- Python LSP setup
      require("lspconfig").pyright.setup({
        capabilities = capabilities,
        ft = { "py" },
      })

      -- TypeScript LSP setup
      require("lspconfig").tsserver.setup({
        capabilities = capabilities,
        ft = { "ts", "js" },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local c = vim.lsp.get_client_by_id(args.data.client_id)
          if not c then
            return
          end
          if
              vim.bo.filetype == "lua"
              or vim.bo.filetype == "c"
              or vim.bo.filetype == "cpp"
              or vim.bo.filetype == "py"
              or vim.bo.filetype == "ts"
              or vim.bo.filetype == "js"
          then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
              end,
            })
          end
        end,
      })
    end,
  },
}
