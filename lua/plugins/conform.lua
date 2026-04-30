local M = {}

M.packages = {
  {
    src = "https://github.com/stevearc/conform.nvim.git",
    name = "conform.nvim",
  },
}

function M.setup()
  vim.cmd("packadd conform.nvim")

  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      python = { "ruff" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      h = { "clang_format" },
      hpp = { "clang_format" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      ["*"] = { "trim_whitespace" },
    },
    formatters = {
      clang_format = {
        prepend_args = { "--style=file", "--fallback-style=LLVM" },
      },
    },
    format_on_save = nil,
  })

  local function format_changed_lines()
    local conform = require("conform")
    local minidiff = require("mini.diff")

    if not minidiff or not minidiff.get_hunks then
      conform.format({ async = false, lsp_fallback = true })
      return
    end

    local hunks = minidiff.get_hunks()
    if not hunks or next(hunks) == nil then
      return
    end

    local ranges = {}
    for _, hunk in pairs(hunks) do
      ranges[#ranges + 1] = {
        start = { hunk.buf_start, 0 },
        ["end"] = { hunk.buf_start + hunk.buf_count, 0 },
      }
    end

    conform.format({
      async = false,
      lsp_fallback = true,
      range = ranges[1],
    })
  end

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("ConformChangedLineFormatting", { clear = true }),
    callback = function(args)
      local formatters = require("conform").list_formatters(args.buf)
      if #formatters > 0 then
        format_changed_lines()
      end
    end,
  })

  vim.keymap.set({ "n", "v" }, "<leader>cf", function()
    require("conform").format({ async = true, lsp_fallback = true })
  end, { desc = "Format buffer" })

  vim.keymap.set({ "n", "v" }, "<leader>cF", function()
    require("conform").format({ formatters = { "injected" }, async = true })
  end, { desc = "Format injected languages" })
end

return M
