local M = {}

M.packages = {
  {
    src = "https://github.com/nvim-lualine/lualine.nvim.git",
    name = "lualine.nvim",
  },
}

--- Loads lualine, wires refresh hooks, and configures the statusline layout.
function M.setup()
  vim.cmd("packadd lualine.nvim")

  --- Returns the active macro recording register for display, or an empty string when idle.
  local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
      return ""
    end

    return "Recording @" .. recording_register
  end

  vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
      require("lualine").refresh({ place = { "statusline" } })
    end,
  })

  vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
      local timer = vim.uv.new_timer()
      timer:start(
        50,
        0,
        vim.schedule_wrap(function()
          require("lualine").refresh({ place = { "statusline" } })
          timer:stop()
          timer:close()
        end)
      )
    end,
  })

  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {
          "alpha",
          "checkhealth",
          "dashboard",
          "snacks_dashboard",
          "fzf",
          "mason",
        },
        winbar = {
          "alpha",
          "checkhealth",
          "dashboard",
          "snacks_dashboard",
          "fzf",
          "mason",
        },
      },
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = {
        { show_macro_recording },
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      },
      lualine_y = { "fileformat", "filetype" },
      lualine_z = { "encoding" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { "neo-tree" },
  })
end

return M