local M = {}

M.packages = {}

local function escape_magic(symbol)
  return vim.fn.escape(symbol, [[\.^$~[]*]])
end

local function literal_symbol_pattern(symbol, opts)
  opts = opts or {}

  local before = opts.before and (#opts.before > 0 and ([[\%%(%s\)\@<!]]):format(opts.before) or "") or ""
  local after = opts.after and (#opts.after > 0 and ([[\%%(%s\)\@!]]):format(opts.after) or "") or ""

  return before .. escape_magic(symbol) .. after
end

local function keyword_symbol_pattern(symbol)
  return ([[\%%(\k\)\@<!%s\%%(\k\)\@!]]):format(symbol)
end

local glyph_matches = {
  { group = "GlyphStrictNotEqual", pattern = literal_symbol_pattern("!==", { after = "=" }), char = "≢" },
  { group = "GlyphStrictEqual", pattern = literal_symbol_pattern("===", { before = "=", after = "=" }), char = "≣" },
  { group = "GlyphEllipsis", pattern = literal_symbol_pattern("...", { before = [[\.]], after = [[\.]] }), char = "…" },
  { group = "GlyphArrowRight", pattern = literal_symbol_pattern("->", { before = "-", after = "-" }), char = "→" },
  { group = "GlyphArrowLeft", pattern = literal_symbol_pattern("<-", { before = "-", after = "-" }), char = "←" },
  { group = "GlyphFatArrow", pattern = literal_symbol_pattern("=>", { before = "=", after = [[=\|>]] }), char = "⇒" },
  { group = "GlyphNotEqual", pattern = literal_symbol_pattern("!=", { after = "=" }), char = "≠" },
  { group = "GlyphLuaNotEqual", pattern = literal_symbol_pattern("~=", { after = "=" }), char = "≠" },
  { group = "GlyphLessEqual", pattern = literal_symbol_pattern("<=", { before = "<", after = "=" }), char = "≤" },
  { group = "GlyphGreaterEqual", pattern = literal_symbol_pattern(">=", { before = ">", after = "=" }), char = "≥" },
  { group = "GlyphEqual", pattern = literal_symbol_pattern("==", { before = "=", after = "=" }), char = "≡" },
  { group = "GlyphLambda", pattern = keyword_symbol_pattern([[\\lambda]]), char = "λ" },
  { group = "GlyphPi", pattern = keyword_symbol_pattern([[\\pi]]), char = "π" },
}

local supported_filetypes = {
  bash = true,
  c = true,
  cmake = true,
  cpp = true,
  css = true,
  dockerfile = true,
  gitcommit = true,
  go = true,
  html = true,
  javascript = true,
  json = true,
  jsonc = true,
  lua = true,
  markdown = true,
  markdown_inline = true,
  python = true,
  sh = true,
  text = true,
  toml = true,
  tsx = true,
  typescript = true,
  typst = true,
  vim = true,
  yaml = true,
}

local glyphs_enabled = true
local window_match_ids = {}

local function mode_supports_glyphs()
  local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
  return mode == "n" or mode == "v" or mode == "V" or mode == "\22"
end

local function supports_buffer(bufnr)
  if not glyphs_enabled or not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end

  if vim.bo[bufnr].buftype ~= "" then
    return false
  end

  return supported_filetypes[vim.bo[bufnr].filetype] == true
end

local function set_window_conceal(winid, enabled)
  if not vim.api.nvim_win_is_valid(winid) then
    return
  end

  vim.wo[winid].conceallevel = enabled and 2 or 0
  vim.wo[winid].concealcursor = enabled and "nv" or ""
end

local function clear_window_matches(winid)
  if not vim.api.nvim_win_is_valid(winid) then
    window_match_ids[winid] = nil
    return
  end

  for _, match_id in ipairs(window_match_ids[winid] or {}) do
    pcall(vim.fn.matchdelete, match_id, winid)
  end

  window_match_ids[winid] = nil
end

local function define_window_matches(winid)
  if not vim.api.nvim_win_is_valid(winid) then
    return
  end

  clear_window_matches(winid)

  local match_ids = {}
  vim.api.nvim_win_call(winid, function()
    for _, glyph in ipairs(glyph_matches) do
      local match_id = vim.fn.matchadd("Conceal", glyph.pattern, 10, -1, { conceal = glyph.char })
      table.insert(match_ids, match_id)
    end
  end)

  window_match_ids[winid] = match_ids
end

local function apply_glyphs(winid)
  if not vim.api.nvim_win_is_valid(winid) then
    return
  end

  local bufnr = vim.api.nvim_win_get_buf(winid)
  local enabled = supports_buffer(bufnr) and mode_supports_glyphs()

  if not supports_buffer(bufnr) then
    clear_window_matches(winid)
    set_window_conceal(winid, false)
    return
  end

  if not window_match_ids[winid] then
    define_window_matches(winid)
  end

  set_window_conceal(winid, enabled)
end

local function refresh_visible_windows(force)
  for _, winid in ipairs(vim.api.nvim_list_wins()) do
    if force then
      clear_window_matches(winid)
    end
    apply_glyphs(winid)
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("GlyphTranslations", { clear = true })

  vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter", "FileType" }, {
    group = group,
    callback = function(ev)
      for _, winid in ipairs(vim.fn.win_findbuf(ev.buf)) do
        apply_glyphs(winid)
      end
    end,
  })

  vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    callback = function()
      apply_glyphs(vim.api.nvim_get_current_win())
    end,
  })

  vim.api.nvim_create_autocmd("ModeChanged", {
    group = group,
    callback = function()
      refresh_visible_windows()
    end,
  })

  vim.api.nvim_create_autocmd("WinClosed", {
    group = group,
    callback = function(ev)
      clear_window_matches(tonumber(ev.match))
    end,
  })

  vim.api.nvim_create_user_command("GlyphsToggle", function()
    glyphs_enabled = not glyphs_enabled
    refresh_visible_windows(true)
    vim.notify(
      glyphs_enabled and "Glyph translations enabled" or "Glyph translations disabled",
      vim.log.levels.INFO
    )
  end, { desc = "Toggle text-to-glyph translations" })

  vim.keymap.set("n", "<leader>u", "<nop>", { desc = "+ui" })
  vim.keymap.set("n", "<leader>ug", "<cmd>GlyphsToggle<cr>", { desc = "Toggle glyph translations" })

  refresh_visible_windows(true)
end

return M