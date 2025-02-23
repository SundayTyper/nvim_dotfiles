local function format_changes()
  local MiniDiff = require("mini.diff")
  local data = MiniDiff.get_buf_data()
  if not data or not data.hunks then
    vim.notify("No hunks in this buffer")
    return
  end
  local format = require("conform").format
  -- stylua range format mass up indent, so use full format for now
  if vim.tbl_contains(range_ignore_filetypes, vim.bo.filetype) then
    format({ lsp_fallback = true, timeout_ms = 500 })
    return
  end
  local ranges = {}
  for _, hunk in pairs(data.hunks) do
    if hunk.type ~= "delete" then
      -- always insert to index 1 so format below could start from last hunk, which this sort didn't mess up range
      table.insert(ranges, 1, {
        start = { hunk.buf_start, 0 },
        ["end"] = { hunk.buf_start + hunk.buf_count, 0 },
      })
    end
  end
  for _, range in pairs(ranges) do
    format({ lsp_fallback = true, timeout_ms = 500, range = range })
  end
end

return {
  {
    "stevearc/conform.nvim",
    dependancies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    event = "VeryLazy",
    opts = {
      notify_on_error = true,
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
      },
      format_on_save = function()
        format_changes()
      end,
      -- Set default options
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters = {
        clang_format = {
          prepend_args = { "--style=file", "--fallback-style=LLVM" },
        },
      },
    },
  },
}
