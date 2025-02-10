-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

local A = {}

local configCmake = function()
  local function is_cmake_project() -- Improved CMake project check
    local current_dir = vim.fn.getcwd()
    local project_root = vim.fn.findfile("CMakeLists.txt", current_dir)
    return project_root ~= ""
  end

  if is_cmake_project() then -- Check if it is a cmake project
    local ok, err = pcall(vim.api.nvim_command, [[Task start cmake configure]]) -- Error handling
    if ok then
      vim.notify("CMake configure started.", "info")
    else
      vim.notify("CMake configure failed: " .. err, "error")
      print("CMake configure failed: " .. err)
    end
  end
end

A.commands = {
  FileType = {
    makefile = function()
      vim.opt.expandtab = false
      vim.opt.tabstop = 8
      vim.opt.shiftwidth = 8
    end,
  },
  -- Run Cmake configure on saving a C/C++ file
  BufWrite = {
    c = configCmake(),
    cpp = configCmake(),
    h = configCmake(),
    hpp = configCmake(),
  },
}

return A
