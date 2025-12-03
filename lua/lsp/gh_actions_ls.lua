return {
  -- cmd = { 'github-actions-language-server', '--stdio' },
  -- filetypes = { 'yaml' },
  -- root_markers = { '.github/workflows', '.git' },
  --
  -- on_attach = function(client, bufnr)
  --   -- Only enable for GitHub Actions workflow files
  --   local bufname = vim.api.nvim_buf_get_name(bufnr)
  --   if not bufname:match('%.github/workflows/.*%.ya?ml$') then
  --     vim.lsp.stop_client(client.id)
  --   end
  -- end,
}
