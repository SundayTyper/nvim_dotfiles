local M = {}

M.packages = {
  {
    src = "https://github.com/ibhagwan/fzf-lua.git",
    name = "fzf-lua",
  },
}

--- Returns a callable wrapper around a named fzf-lua picker and its options.
local function picker(name, opts)
  return function()
    require("fzf-lua")[name](opts or {})
  end
end

--- Returns the nearest git root for the current buffer, falling back to cwd.
local function project_root()
  local bufname = vim.api.nvim_buf_get_name(0)
  local start = bufname ~= "" and vim.fs.dirname(bufname) or vim.fn.getcwd()
  local git_dir = vim.fs.find({ ".git" }, {
    path = start,
    upward = true,
    type = "directory",
  })[1]

  if git_dir then
    return vim.fs.dirname(git_dir)
  end

  return vim.fn.getcwd()
end

--- Opens a project-root live grep picker with an always-visible floating preview.
local function project_search()
  require("fzf-lua").live_grep({
    cwd = project_root(),
    prompt = "Project> ",
    formatter = "path.filename_first",
    winopts = {
      title = " Project Search ",
      width = 0.9,
      height = 0.85,
      preview = {
        hidden = false,
        layout = "horizontal",
        horizontal = "right:55%",
      },
    },
  })
end

--- Loads fzf-lua, configures picker defaults, and registers navigation keymaps.
function M.setup()
  vim.cmd("packadd fzf-lua")

  require("fzf-lua").setup({
    file_icons = "mini",
    files = {
      cwd_prompt = false,
    },
    oldfiles = {
      include_current_session = true,
    },
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
    },
    grep = {
      rg_glob = true,
    },
  })

  vim.keymap.set("n", "<leader>f", "<nop>", { desc = "+find" })
  vim.keymap.set("n", "<leader>ff", picker("files"), { desc = "Find Files" })
  vim.keymap.set("n", "<leader>fg", project_search, { desc = "Project Search" })
  vim.keymap.set("n", "<leader>fb", picker("buffers"), { desc = "Buffers" })
  vim.keymap.set("n", "<leader>fh", picker("help_tags"), { desc = "Help Tags" })
  vim.keymap.set("n", "<leader>fo", picker("oldfiles"), { desc = "Recent Files" })
  vim.keymap.set("n", "<leader>fc", picker("commands"), { desc = "Commands" })
  vim.keymap.set("n", "<leader>fk", picker("keymaps"), { desc = "Keymaps" })
  vim.keymap.set("n", "<leader>fm", picker("marks"), { desc = "Marks" })
  vim.keymap.set("n", "<leader>fr", picker("resume"), { desc = "Resume Last" })

  vim.keymap.set("n", "<leader>s", "<nop>", { desc = "+search" })
  vim.keymap.set("n", "<leader>sw", picker("grep_cword"), { desc = "Search Word Under Cursor" })
  vim.keymap.set("n", "<leader>sb", picker("blines"), { desc = "Search Current Buffer" })

  vim.keymap.set("n", "<leader>ls", picker("lsp_document_symbols"), { desc = "Document Symbols" })
  vim.keymap.set("n", "<leader>lS", picker("lsp_workspace_symbols"), { desc = "Workspace Symbols" })
  vim.keymap.set("n", "gd", picker("lsp_definitions"), { desc = "Goto Definition" })
  vim.keymap.set("n", "gD", picker("lsp_declarations"), { desc = "Goto Declaration" })
  vim.keymap.set("n", "gr", picker("lsp_references"), { desc = "References", nowait = true })
  vim.keymap.set("n", "gI", picker("lsp_implementations"), { desc = "Goto Implementation" })
  vim.keymap.set("n", "gy", picker("lsp_typedefs"), { desc = "Goto T[y]pe Definition" })
  vim.keymap.set("n", "gai", picker("lsp_incoming_calls"), { desc = "C[a]lls Incoming" })
  vim.keymap.set("n", "gao", picker("lsp_outgoing_calls"), { desc = "C[a]lls Outgoing" })
end

return M