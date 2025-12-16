-- lsp

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Ensure client is valid
    if client then
      -- Set buffer-local options
      vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

      -- Enable inlay hints if supported (Neovim 0.10+)
      if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
      end
    end
  end,
})
