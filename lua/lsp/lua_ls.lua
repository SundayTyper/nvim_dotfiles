return {
  -- comand to start language server
  cmd = { 'lua-language-server' },

  -- Filetypes to attach to
  filetypes = { ' lua' },

  -- root marker for files...
  -- this will allow sharing of project config files for the language
  root_markers = { { '.luarc.json', '.luarc.jsonrc' }, '.git' },

  -- server specific settings
  -- https://raw.githubusercontent.com/LuaLS/vscode-lua/master/settings/schema.json
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- recognise 'vim' global
        gloabsl = { 'vim' },
      },
    }
  }
}
