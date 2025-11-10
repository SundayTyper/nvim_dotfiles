-- File: lua/plugins/none-ls-config.lua

-- format changes on save
-- Define the custom format function that leverages mini.diff
local function format_changed_lines()
  local nls = require("null-ls")
  local minidiff = require("mini.diff")

  -- 1. Check if mini.diff is available and active
  if not minidiff or not minidiff.get_hunks then
    -- Fallback to full buffer formatting if mini.diff is not available
    nls.format_sync({})
    return
  end

  -- 2. Get the changed hunks (line ranges) from mini.diff
  local hunks = minidiff.get_hunks()

  -- If no hunks (no changes) are found, just return (nothing to format)
  if not hunks or next(hunks) == nil then
    return
  end

  -- 3. Convert hunks into format ranges
  local ranges = {}
  for _, hunk in pairs(hunks) do
    -- A hunk is defined by its start line and end line.
    -- mini.diff returns 1-based line numbers, which is what the LSP expects.
    table.insert(ranges, {
      start = hunk.line_start,
      ["end"] = hunk.line_end,
    })
  end

  -- 4. Execute the none-ls format function on the calculated ranges
  -- Note: We use nls.format_sync() here to ensure the changes are applied
  -- before the file is written.
  nls.format_sync({
    ranges = ranges,
    -- If true, it formats the whole buffer if range formatting fails.
    fallback = true,
  })

  vim.wait(20, function()
    return true
  end)
end

return {
  {
    -- Plugin: nvimtools/none-ls.nvim
    "nvimtools/none-ls.nvim",
    -- Ensure Mason loads first to find the executables
    dependencies = { "mason.nvim" },
    -- Load only when needed (LazyVim default is often 'VeryLazy')
    event = "VeryLazy",

    opts = function(_, opts)
      local nls = require("null-ls") -- The required name for the none-ls API

      -- Initialize opts.sources and extend with new built-ins
      opts.sources = vim.list_extend(opts.sources or {}, {

        -- 📜 LINTERS (Diagnostics) ----------------------------------------------

        -- Actionlint (GitHub Actions)
        nls.builtins.diagnostics.actionlint,

        -- Shellcheck (Shell Scripts)
        nls.builtins.diagnostics.shellcheck,

        -- Hadolint (Dockerfile Linter)
        nls.builtins.diagnostics.hadolint,

        -- ESLint (JavaScript/TypeScript)
        nls.builtins.diagnostics.eslint,

        -- Codespell (Spelling Checker)
        nls.builtins.diagnostics.codespell,

        -- CSpell (Code Spell Checker)
        nls.builtins.diagnostics.cspell,

        -- Markdownlint (Markdown files)
        nls.builtins.diagnostics.markdownlint,

        -- Cmakelang (CMake Linter)
        nls.builtins.diagnostics.cmakelint, -- Use the cmakelint built-in for linting

        -- cppcheck (C/C++ Static Analyzer)
        nls.builtins.diagnostics.cppcheck.with({
          -- Optional: Customize arguments for cppcheck
          args = {
            "--enable=all", -- Recommended: Enables all checks
            "--inconclusive", -- Show inconclusive results
            "--template={file}:{line}:{severity}:{message}",
            "$FILENAME",
          },
          filetypes = { "c", "cpp" },
        }),

        -- 📐 FORMATTERS --------------------------------------------------------

        -- Stylua (Lua Formatter)
        nls.builtins.formatting.stylua,

        -- shfmt (Shell Script Formatter)
        nls.builtins.formatting.shfmt,

        -- Ruff (Python Formatter)
        -- Note: If you use the 'ruff' LSP, it can handle formatting,
        -- but this ensures it works via the standard format command.
        nls.builtins.formatting.ruff,

        -- Cmakelang (CMake Formatter)
        nls.builtins.formatting.cmakeformat, -- Use cmakeformat built-in for formatting

        -- CLANG-FORMAT (C/C++/H Formatter)
        nls.builtins.formatting.clang_format.with({
          -- Ensure it only runs on the relevant files
          filetypes = { "c", "cpp", "h" },
          -- The key argument that tells clang-format to find a project config
          args = { "--style=file" },
        }),

        -- Prettier for Markdown, JSON, YAML (optional but common)
        nls.builtins.formatting.prettier.with({
          filetypes = { "json", "yaml", "markdown", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        }),
      })

      -- Set the update events for diagnostics (common LazyVim practice)
      opts.on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("NoneLsChangedLineFormatting", { clear = true }),
            buffer = bufnr,
            -- Call our custom function that uses mini.diff
            callback = format_changed_lines,
          })
        end
      end
      return opts
    end,
  },
}
