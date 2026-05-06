-- autocmds

-- buffer settings group for specific filetypes
local filetype_settings_group = vim.api.nvim_create_augroup("FileTypeSpecificSettings", { clear = true })

-- Settings for Makefiles
vim.api.nvim_create_autocmd("FileType", {
  group = filetype_settings_group,
  pattern = "makefile",
  --- Applies Makefile indentation settings that require literal tabs.
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
  end,
})

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  --- Briefly highlights freshly yanked text for visual feedback.
  callback = function()
    vim.highlight.on_yank()
  end,
})

--- Updates the global window orientation from the current window dimensions.
local function set_window_orientation()
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)
  vim.g.window_orientation = width >= height and "landscape" or "portrait"
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter", "VimResized" }, {
  group = vim.api.nvim_create_augroup("TrackWindowOrientation", { clear = true }),
  desc = "Track whether the current window is landscape or portrait",
  callback = set_window_orientation,
})

set_window_orientation()

-- Autosize window splits on window resize
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = vim.api.nvim_create_augroup("EqualizeSplits", { clear = true }),
  --- Rebalances window splits while preserving the current tabpage.
  callback = function()
    local current_tab = vim.api.nvim_get_current_tabpage()
    vim.cmd("tabdo wincmd =")
    vim.api.nvim_set_current_tabpage(current_tab)
  end,
  desc = "Resize splits with terminal window",
})

-- Auto-reload Neovim config when init.lua is saved
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("ReloadConfig", { clear = true }),
  pattern = vim.fn.stdpath("config") .. "/init.lua",
  --- Reloads the top-level init.lua entrypoint after it is saved.
  callback = function()
    vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
    vim.notify("Neovim config reloaded!", vim.log.levels.INFO)
  end,
  desc = "Reload Neovim config after saving init.lua",
})

-- Toggle relative line numbers based on focus and mode
local numbertoggle_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  group = numbertoggle_group,
  --- Re-enables relative numbers when the window returns to normal navigation.
  callback = function()
    vim.opt.relativenumber = true
  end,
  desc = "Enable relative line numbers",
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  group = numbertoggle_group,
  --- Disables relative numbers while focus leaves the window or insert mode begins.
  callback = function()
    vim.opt.relativenumber = false
  end,
  desc = "Disable relative line numbers",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  --- Removes comment continuation flags for new lines in matching buffers.
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

--- Returns whether any LSP client attached to the buffer supports document highlights.
local function supports_document_highlight(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if client.server_capabilities.documentHighlightProvider then
      return true
    end
  end

  return false
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspReferenceHighlightAttach", { clear = true }),
  --- Installs buffer-local reference highlight autocmds when supported by the LSP.
  callback = function(ev)
    if vim.b[ev.buf].lsp_reference_highlights or not supports_document_highlight(ev.buf) then
      return
    end

    vim.b[ev.buf].lsp_reference_highlights = true

    local group = vim.api.nvim_create_augroup("LspReferenceHighlight" .. ev.buf, { clear = true })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group,
      buffer = ev.buf,
      desc = "Highlight references under cursor",
      --- Requests document highlights unless command-line mode is active.
      callback = function()
        if vim.fn.mode() == "c" then
          return
        end

        if not supports_document_highlight(ev.buf) then
          vim.lsp.buf.clear_references()
          return
        end

        vim.lsp.buf.document_highlight()
      end,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertEnter", "BufLeave" }, {
      group = group,
      buffer = ev.buf,
      desc = "Clear LSP reference highlights",
      --- Clears any active document highlights when cursor state changes.
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end,
})