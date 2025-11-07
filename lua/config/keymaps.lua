-- Keymaps

-- logical keymap functions
local delete_line_conditional = function()
  -- Check if the content of the current line ('.') is an empty string
  if vim.fn.getline(".") == "" then
    -- If empty, map to "_dd":
    return vim.api.nvim_replace_termcodes('<C-c>"_dd', true, true, true)
  else
    -- If not empty, map to "dd" (standard delete and yank)
    return vim.api.nvim_replace_termcodes('<C-c>dd', true, true, true)
  end
end


-- don't yank blanklines when deleting them
vim.keymap.set('n', 'dd', delete_line_conditional, {
  silent = true,
  expr = true, -- Use function return as actual command
  desc = 'Conditional line delete (no yank on empty line)'
})

-- Interact with system clipboard
vim.keymap.set({ 'n', 'x' }, '<leader>yy', '"+yy', { desc = 'Copy to system clipboard' })
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard after cursor' })
vim.keymap.set({ 'n', 'x' }, '<leader>P', '"+P', { desc = 'Paste from system clipboard before cursor' })
