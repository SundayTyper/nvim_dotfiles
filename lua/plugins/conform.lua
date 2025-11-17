-- Conform.nvim - Modern formatting plugin
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    dependencies = { "mason.nvim" },

    opts = {
      -- Define formatters by filetype
      formatters_by_ft = {
        -- Lua
        lua = { "stylua" },

        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- C/C++
        c = { "clang_format" },
        cpp = { "clang_format" },
        h = { "clang_format" },
        hpp = { "clang_format" },

        -- Web/Markup
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

        -- Use trim_whitespace for all files
        ["*"] = { "trim_whitespace" },
      },

      -- Customize formatters
      formatters = {
        clang_format = {
          prepend_args = { "--style=file", "--fallback-style=LLVM" },
        },
      },

      -- Format on save is handled by autocmd below
      format_on_save = nil,
    },

    config = function(_, opts)
      require("conform").setup(opts)

      -- Format changed lines on save using mini.diff
      local function format_changed_lines()
        local conform = require("conform")
        local minidiff = require("mini.diff")

        -- Check if mini.diff is available
        if not minidiff or not minidiff.get_hunks then
          -- Fallback to full buffer formatting
          conform.format({ async = false, lsp_fallback = true })
          return
        end

        -- Get changed hunks from mini.diff
        local hunks = minidiff.get_hunks()

        -- If no changes, return
        if not hunks or next(hunks) == nil then
          return
        end

        -- Convert hunks to ranges for conform
        local ranges = {}
        for _, hunk in pairs(hunks) do
          table.insert(ranges, {
            start = { hunk.buf_start, 0 },
            ["end"] = { hunk.buf_start + hunk.buf_count, 0 },
          })
        end

        -- Format the ranges
        conform.format({
          async = false,
          lsp_fallback = true,
          range = ranges[1], -- Conform processes one range at a time
        })
      end

      -- Set up autocmd for format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("ConformChangedLineFormatting", { clear = true }),
        callback = function(args)
          -- Only format if conform has formatters for this filetype
          local formatters = require("conform").list_formatters(args.buf)
          if #formatters > 0 then
            format_changed_lines()
          end
        end,
      })
    end,

    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" }, async = true })
        end,
        mode = "",
        desc = "Format injected languages",
      },
    },
  },
}
