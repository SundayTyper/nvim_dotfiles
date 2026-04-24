-- lsp

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Ensure client is valid
    if client then
      -- Set buffer-local options
      vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

      -- Enable inlay hints only in insert mode (Neovim 0.10+)
      if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
        local group = vim.api.nvim_create_augroup("LspInlayHints" .. ev.buf, { clear = true })
        vim.api.nvim_create_autocmd("InsertEnter", {
          group = group,
          buffer = ev.buf,
          callback = function()
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
          end,
        })
        vim.api.nvim_create_autocmd("InsertLeave", {
          group = group,
          buffer = ev.buf,
          callback = function()
            vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
          end,
        })
      end
    end
  end,
})
