-- FZF-lua configuration with comprehensive LSP integration
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
      files = {
        prompt = "Files❯ ",
        cmd = "rg --files --hidden --follow -g '!.git'",
        git_icons = true,
        file_icons = true,
        color_icons = true,
      },
      grep = {
        prompt = "Grep❯ ",
        input_prompt = "Grep For❯ ",
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
        git_icons = true,
        file_icons = true,
        color_icons = true,
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
      -- File & Buffer Navigation
      { "<leader>f", group = "Find" }, -- which-key category
      { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Buffers" },

      -- LSP Actions
      { "<leader>l", group = "LSP" }, -- which-key category
      { "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", desc = "Definitions" },
      { "<leader>lr", "<cmd>FzfLua lsp_references<CR>", desc = "References" },
      { "<leader>li", "<cmd>FzfLua lsp_implementations<CR>", desc = "Implementations" },
      { "<leader>lt", "<cmd>FzfLua lsp_typedefs<CR>", desc = "Type definitions" },
      { "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>", desc = "Document symbols" },
      { "<leader>lw", "<cmd>FzfLua lsp_workspace_symbols<CR>", desc = "Workspace symbols" },
      { "<leader>lW", "<cmd>FzfLua lsp_live_workspace_symbols<CR>", desc = "Live workspace symbols" },
      { "<leader>la", "<cmd>FzfLua lsp_code_actions<CR>", desc = "Code actions" },
      { "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover documentation" },
      { "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol" },
      { "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover documentation" },

      -- Diagnostics
      { "<leader>d", group = "Diagnostics" }, -- which-key category
      { "<leader>dd", "<cmd>FzfLua diagnostics_document<CR>", desc = "Document diagnostics" },
      { "<leader>dw", "<cmd>FzfLua diagnostics_workspace<CR>", desc = "Workspace diagnostics" },
      { "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous diagnostic" },
      { "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next diagnostic" },

      -- Search
      { "<leader>s", group = "Search" }, -- which-key category
      { "<leader>sw", "<cmd>FzfLua grep_cword<CR>", desc = "Search word under cursor" },
      { "<leader>sW", "<cmd>FzfLua grep_cWORD<CR>", desc = "Search WORD under cursor" },
      { "<leader>sv", "<cmd>FzfLua grep_visual<CR>", desc = "Search visual selection", mode = "v" },
      { "<leader>sb", "<cmd>FzfLua lgrep_curbuf<CR>", desc = "Live grep current buffer" },
    },
  },
}
