-- lsp

vim.api.nvim_create_autocmd("LspAttach", {
  --- Configures buffer-local LSP behavior when a language server attaches.
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Ensure client is valid
    if client then
      -- Set buffer-local options
      vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

      if client.name == "clangd" then
        vim.keymap.set("n", "<M-o>", "<cmd>LspClangdSwitchSourceHeader<cr>", {
          buffer = ev.buf,
          desc = "Switch Header/Source",
        })
      end
    end
  end,
})
