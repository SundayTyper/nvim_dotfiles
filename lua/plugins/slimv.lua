-- slimv.lua
return {
  {
    "kovisoft/slimv",
    lazy = true,
    ft = { "lisp", "cl" }, -- Lazy load for .lisp and .cl files
    config = function()
      -- Start Swank server only for .lisp and .cl files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lisp", "cl" },
        callback = function()
          vim.g.slimv_repl_open = 1       -- Automatically open the REPL window
          vim.g.slimv_swank_autostart = 1 -- Automatically start Swank server
        end,
      })
    end,
  },
}
