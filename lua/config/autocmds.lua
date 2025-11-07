-- autocmds

-- buffer settings group for specific filetypes
local filetype_settings_group = vim.api.nvim_create_augroup('FileTypeSpecificSettings', { clear = true })


-- Settings for Makefiles
vim.api.nvim_create_autocmd('FileType', {
  group = filetype_settings_group,
  pattern = 'makefile',
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
  end,
})


-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
