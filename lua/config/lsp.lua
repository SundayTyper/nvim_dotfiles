-- lsp
--------------------------------------------------------------------------------
-- See https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview
-- of how the lsp setup works in neovim 0.11+.

-- Get default LSP capabilities
local function get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Add blink.cmp capabilities if available
  local has_blink, blink = pcall(require, "blink.cmp")
  if has_blink then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end

  return capabilities
end

-- Load and enhance server configs with capabilities
local servers = {
  "lua_ls",
  "clangd",
  "copilot",
  "ruff",
  "ts_ls",
  "dockerls",
  "yamlls",
  "pyright",
  "neocmake",
  "tinymist",
  "bashls",
  "marksman",
  "jsonls",
  "gh_actions_ls",
}

-- Store enhanced configs in vim.lsp.config
for _, server_name in ipairs(servers) do
  local config_path = vim.fn.stdpath("config") .. "/lua/lsp/" .. server_name .. ".lua"
  local ok, server_config = pcall(dofile, config_path)

  if ok and server_config then
    -- Add capabilities to the config
    server_config.capabilities = get_capabilities()

    -- Register the config with vim.lsp.config
    vim.lsp.config[server_name] = server_config
  end

  -- Enable the server (will use config from vim.lsp.config)
  vim.lsp.enable(server_name)
end

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
