-- Keymaps
--

--- Toggles LSP inlay hints on or off globally.
local function toggle_inlay_hints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

--- Returns the tracked builtin terminal buffer if it is still valid.
local function terminal_buffer()
  local bufnr = vim.g.builtin_terminal_bufnr
  if type(bufnr) ~= "number" or not vim.api.nvim_buf_is_valid(bufnr) then
    return nil
  end

  if vim.bo[bufnr].buftype ~= "terminal" then
    return nil
  end

  return bufnr
end

--- Closes every visible window showing the tracked builtin terminal buffer.
local function close_terminal_windows(bufnr)
  local wins = vim.fn.win_findbuf(bufnr)
  for _, winid in ipairs(wins) do
    if vim.api.nvim_win_is_valid(winid) then
      vim.api.nvim_win_close(winid, false)
    end
  end

  return #wins > 0
end

--- Opens or hides a single shared builtin terminal using the tracked orientation.
local function toggle_builtin_terminal()
  local bufnr = terminal_buffer()
  if bufnr and close_terminal_windows(bufnr) then
    return
  end

  local orientation = vim.g.window_orientation or "landscape"
  if orientation == "landscape" then
    vim.cmd("rightbelow vsplit")
  else
    vim.cmd("rightbelow split")
  end

  if bufnr then
    vim.api.nvim_win_set_buf(0, bufnr)
  else
    vim.cmd("terminal")
    vim.g.builtin_terminal_bufnr = vim.api.nvim_get_current_buf()
  end
end

-- Toggle inlay hints
vim.keymap.set("n", "<leader>lh", toggle_inlay_hints, { desc = "Toggle inlay hints" })
vim.keymap.set("n", "<leader>t", "<nop>", { desc = "+terminal" })
vim.keymap.set("n", "<leader>tt", toggle_builtin_terminal, { desc = "Toggle terminal" })
