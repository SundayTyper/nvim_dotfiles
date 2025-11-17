-- FZF-lua configuration for LSP actions only
-- File/buffer searching migrated to snacks.picker
return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    
    opts = {
      "default-title",
      winopts = {
        height = 0.85,
        width = 0.85,
        row = 0.35,
        col = 0.50,
        border = "rounded",
        preview = {
          border = "rounded",
          wrap = "wrap",
          hidden = "nohidden",
          vertical = "down:45%",
          horizontal = "right:60%",
          layout = "flex",
          flip_columns = 120,
          delay = 10,
          scrollbar = "float",
        },
      },
      fzf_opts = {
        ["--layout"] = "reverse",
        ["--info"] = "inline",
        ["--height"] = "100%",
        ["--border"] = "none",
      },
      lsp = {
        prompt_postfix = "❯ ",
        code_actions = {
          prompt = "Code Actions❯ ",
          winopts = {
            height = 0.40,
            width = 0.60,
          },
        },
      },
    },
    
    keys = {
      -- LSP Actions
      { "<leader>g", group = "LSP" }, -- which-key category
      { "<leader>gr", "<cmd>FzfLua lsp_references<CR>",      desc = "Show LSP references" },
      { "<leader>gd", "<cmd>FzfLua lsp_declarations<CR>",    desc = "Go to declaration" },
      { "<leader>gD", "<cmd>FzfLua lsp_definitions<CR>",     desc = "Show LSP definitions" },
      { "<leader>gi", "<cmd>FzfLua lsp_implementations<CR>", desc = "Show LSP implementations" },
      { "<leader>gt", "<cmd>FzfLua lsp_typedefs<CR>",        desc = "Show LSP type definitions" },
      { "<leader>ga", "<cmd>FzfLua lsp_code_actions<CR>",    desc = "Show LSP code actions" },
      { "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Toggle signature help" },
      { "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover documentation" },

      
      -- Diagnostics
      { "<leader>d", group = "Diagnostics" }, -- which-key category
      { "<leader>dd", "<cmd>FzfLua diagnostics_document<CR>", desc = "Document diagnostics" },
      { "<leader>dw", "<cmd>FzfLua diagnostics_workspace<CR>", desc = "Workspace diagnostics" },
      { "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous diagnostic" },
      { "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next diagnostic" },
    },
  },
}