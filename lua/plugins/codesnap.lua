local M = {}

M.packages = {}

local codesnap_package = {
  src = "https://github.com/mistricky/codesnap.nvim.git",
  name = "codesnap.nvim",
}

local codesnap_config = {
  show_line_number = true,
  show_workspace = false,
  snapshot_config = {
    code_config = {
      font_family = "CaskaydiaCove Nerd Font",
      breadcrumbs = {
        enable = false,
        separator = "  ",
        color = "#7E9CD8",
        font_family = "CaskaydiaCove Nerd Font",
      },
    },
    window = {
      shadow = {
        radius = 0,
        color = "#00000000",
      },
      border = {
        width = 0,
        color = "#00000000",
      },
      title_config = {
        color = "#DCD7BA",
        font_family = "CaskaydiaCove Nerd Font",
      },
    },
    background = "#00000000",
  },
}

--- Shell-escapes a filesystem path for use in external clipboard commands.
local function shell_escape(path)
  return vim.fn.shellescape(path)
end

--- Returns a unique PNG output path in Neovim's cache directory.
local function snapshot_output_path()
  local dir = vim.fn.stdpath("cache") .. "/codesnap"
  vim.fn.mkdir(dir, "p")
  return string.format("%s/%d.png", dir, vim.uv.hrtime())
end

--- Chooses the available system command for copying a PNG to the clipboard.
local function clipboard_command(path)
  if vim.fn.executable("wl-copy") == 1 and vim.env.WAYLAND_DISPLAY then
    return string.format("wl-copy --type image/png < %s", shell_escape(path))
  end

  if vim.fn.executable("xclip") == 1 then
    return string.format("xclip -selection clipboard -t image/png -i %s", shell_escape(path))
  end

  return nil
end

--- Patches CodeSnap to save images first and copy them asynchronously to the clipboard.
local function patch_codesnap_clipboard()
  if vim.g.codesnap_clipboard_patched then
    return
  end

  local ok, generator = pcall(require, "generator")
  if not ok then
    return
  end

  local original_save = generator.save
  if type(original_save) ~= "function" then
    return
  end

  generator.copy = function(config)
    local out = snapshot_output_path()
    original_save(out, config)

    local command = clipboard_command(out)
    if not command then
      vim.notify("Code snapshot saved to " .. out .. " (no image clipboard backend found)", vim.log.levels.WARN)
      return
    end

    vim.system({ "sh", "-c", command }, { text = true }, function(result)
      if result.code ~= 0 then
        local message = (result.stderr or result.stdout or "clipboard copy failed"):gsub("%s+$", "")
        vim.schedule(function()
          vim.notify("CodeSnap clipboard copy failed: " .. message, vim.log.levels.ERROR)
        end)
      end
    end)
  end

  vim.g.codesnap_clipboard_patched = true
end

--- Returns whether the optional CodeSnap package is already installed in packpath.
local function is_codesnap_installed()
  local matches = vim.fn.globpath(vim.o.packpath, "pack/*/opt/codesnap.nvim", false, true)
  return type(matches) == "table" and #matches > 0
end

--- Loads CodeSnap on demand, runs an action, and restores package.cpath afterwards.
local function with_codesnap(action)
  local original_cpath = package.cpath
  local ok, result = xpcall(function()
    if not is_codesnap_installed() then
      vim.pack.add({ codesnap_package }, { confirm = false })
    end

    vim.cmd("packadd codesnap.nvim")

    local codesnap = require("codesnap")
    if not vim.g.codesnap_initialized then
      codesnap.setup(vim.deepcopy(codesnap_config))
      vim.g.codesnap_initialized = true
    end

    patch_codesnap_clipboard()

    return action(codesnap)
  end, debug.traceback)

  package.cpath = original_cpath

  if not ok then
    vim.notify(tostring(result), vim.log.levels.ERROR)
  end

  return result
end

--- Captures the current visual selection bounds in start-to-end order.
local function capture_visual_range()
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")

  if start_pos[2] > end_pos[2] or (start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3]) then
    start_pos, end_pos = end_pos, start_pos
  end

  return {
    start_pos = start_pos,
    end_pos = end_pos,
  }
end

--- Restores a previously captured visual selection range into visual marks.
local function apply_visual_range(range)
  if not range then
    return
  end

  vim.fn.setpos("'<", range.start_pos)
  vim.fn.setpos("'>", range.end_pos)
end

--- Reapplies a visual range and invokes the named CodeSnap action.
local function run_codesnap(action_name, range)
  with_codesnap(function(codesnap)
    apply_visual_range(range)
    codesnap[action_name]()
  end)
end

--- Registers commands and mappings for copying code snapshots from selections.
function M.setup()
  vim.api.nvim_create_user_command("CodeSnapSelection", function(opts)
    run_codesnap("copy", {
      start_pos = { 0, opts.line1, 1, 0 },
      end_pos = { 0, opts.line2, vim.v.maxcol, 0 },
    })
  end, { desc = "Copy selected code snapshot", range = true })

  vim.api.nvim_create_user_command("CodeSnapSelectionHighlight", function(opts)
    run_codesnap("copy_highlight", {
      start_pos = { 0, opts.line1, 1, 0 },
      end_pos = { 0, opts.line2, vim.v.maxcol, 0 },
    })
  end, { desc = "Copy selected code snapshot with highlights", range = true })

  vim.keymap.set("x", "<leader>cs", function()
    run_codesnap("copy", capture_visual_range())
  end, { desc = "Copy code snapshot" })

  vim.keymap.set("x", "<leader>cS", function()
    run_codesnap("copy_highlight", capture_visual_range())
  end, { desc = "Copy highlighted snapshot" })
end

return M