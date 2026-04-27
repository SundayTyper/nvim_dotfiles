local M = {}

M.packages = {
  {
    src = "https://github.com/Olical/conjure.git",
    name = "conjure",
  },
  {
    src = "https://github.com/bakpakin/Fennel.vim.git",
    name = "fennel.vim",
  },
}

function M.setup()
  vim.g["conjure#client_on_load"] = false
  vim.g["conjure#mapping#prefix"] = "<leader>k"
  vim.g["conjure#mapping#def_word"] = "d"
  vim.g["conjure#mapping#doc_word"] = "h"
  vim.g["conjure#mapping#eval_buf"] = "b"
  vim.g["conjure#mapping#eval_current_form"] = "e"
  vim.g["conjure#mapping#eval_file"] = "f"
  vim.g["conjure#mapping#eval_motion"] = "m"
  vim.g["conjure#mapping#eval_previous"] = "p"
  vim.g["conjure#mapping#eval_replace_form"] = "x"
  vim.g["conjure#mapping#eval_root_form"] = "r"
  vim.g["conjure#mapping#eval_visual"] = "e"

  vim.cmd("packadd fennel.vim")
  vim.cmd("packadd conjure")

  vim.keymap.set({ "n", "v" }, "<leader>k", "<nop>", { desc = "+lisp" })
  vim.keymap.set("n", "<leader>kc", "<nop>", { desc = "+connect" })
  vim.keymap.set("n", "<leader>kl", "<nop>", { desc = "+log" })
end

return M