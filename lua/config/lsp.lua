-- lsp
--------------------------------------------------------------------------------
-- See https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview
-- of how the lsp setup works in neovim 0.11+.

-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.
vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("ruff")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Ensure client is valid and the completion system (nvim-cmp) is used
    if client then
      -- Set buffer-local options (good practice)
      vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    end
  end,
})
