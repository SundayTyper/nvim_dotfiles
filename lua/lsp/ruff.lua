-- File: lsp/ruff.lua
return {
  cmd = { 'ruff', 'server' }, -- The 'server' argument is crucial
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.git' },

  -- Highly recommended settings for Ruff
  init_options = {
    settings = {
      -- You can configure Ruff options here, or let it read your pyproject.toml
      logLevel = 'info',
    }
  }
}
