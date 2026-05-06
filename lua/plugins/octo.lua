local M = {}

M.packages = {
  {
    src = "https://github.com/pwntester/octo.nvim.git",
    name = "octo.nvim",
  },
  {
    src = "https://github.com/nvim-lua/plenary.nvim.git",
    name = "plenary.nvim",
  },
  {
    src = "https://github.com/nvim-telescope/telescope.nvim.git",
    name = "telescope.nvim",
  },
  {
    src = "https://github.com/nvim-tree/nvim-web-devicons.git",
    name = "nvim-web-devicons",
  },
}

--- Loads Octo, configures GitHub review behavior, and registers PR workflow keymaps.
function M.setup()
  vim.cmd("packadd plenary.nvim")
  vim.cmd("packadd telescope.nvim")
  vim.cmd("packadd nvim-web-devicons")
  vim.cmd("packadd octo.nvim")

  require("octo").setup({
        use_local_fs = false,
        enable_builtin = true,
        default_remote = { "upstream", "origin" },
        default_merge_method = "merge",
        ssh_aliases = {},
        picker = "telescope",
        picker_config = {
          use_emojis = true,
        },
        comment_icon = "▎",
        outdated_icon = "󰅒 ",
        resolved_icon = " ",
        reaction_viewer_hint_icon = " ",
        user_icon = " ",
        timeline_marker = " ",
        timeline_indent = 2,
        right_bubble_delimiter = "",
        left_bubble_delimiter = "",
        github_hostname = "",
        snippet_context_lines = 4,
        gh_cmd = "gh",
        gh_env = {},
        timeout = 5000,
        ui = {
          use_signcolumn = true,
        },
        issues = {
          order_by = {
            field = "CREATED_AT",
            direction = "DESC",
          },
        },
        pull_requests = {
          order_by = {
            field = "CREATED_AT",
            direction = "DESC",
          },
          always_select_remote_on_create = false,
        },
        file_panel = {
          size = 10,
          use_icons = true,
        },
        mappings = {
          pull_request = {
            checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
            list_commits = { lhs = "<space>pc", desc = "list PR commits" },
            list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
            show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
            reload = { lhs = "<C-r>", desc = "reload PR" },
            open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            goto_file = { lhs = "gf", desc = "go to file" },
            add_assignee = { lhs = "<space>aa", desc = "add assignee" },
            remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
            add_comment = { lhs = "<space>ca", desc = "add comment" },
            delete_comment = { lhs = "<space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
          },
          review_thread = {
            add_comment = { lhs = "<space>ca", desc = "add comment" },
            add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
            delete_comment = { lhs = "<space>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
            select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
          },
          submit_win = {
            approve_review = { lhs = "<C-a>", desc = "approve review" },
            comment_review = { lhs = "<C-m>", desc = "comment review" },
            request_changes = { lhs = "<C-r>", desc = "request changes review" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          },
          review_diff = {
            submit_review = { lhs = "<leader>vs", desc = "submit review" },
            discard_review = { lhs = "<leader>vd", desc = "discard review" },
            add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
            add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            next_thread = { lhs = "]t", desc = "move to next thread" },
            prev_thread = { lhs = "[t", desc = "move to previous thread" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
            select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
            goto_file = { lhs = "gf", desc = "go to file" },
          },
          file_panel = {
            submit_review = { lhs = "<leader>vs", desc = "submit review" },
            discard_review = { lhs = "<leader>vd", desc = "discard review" },
            next_entry = { lhs = "j", desc = "move to next changed file" },
            prev_entry = { lhs = "k", desc = "move to previous changed file" },
            select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
            refresh_files = { lhs = "R", desc = "refresh changed files panel" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
            select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
          },
        },
      })

  vim.keymap.set("n", "<leader>gp", "<nop>", { desc = "+pull request" })
  vim.keymap.set("n", "<leader>gpl", "<cmd>Octo pr list<cr>", { desc = "List PRs" })
  vim.keymap.set("n", "<leader>gps", "<cmd>Octo pr search<cr>", { desc = "Search PRs" })
  vim.keymap.set("n", "<leader>gpo", "<cmd>Octo pr checkout<cr>", { desc = "Checkout PR" })
  vim.keymap.set("n", "<leader>gpr", "<cmd>Octo review start<cr>", { desc = "Start Review" })
  vim.keymap.set("n", "<leader>gpR", "<cmd>Octo review resume<cr>", { desc = "Resume Review" })
  vim.keymap.set("n", "<leader>gpb", "<cmd>Octo pr browser<cr>", { desc = "Open PR in Browser" })
  vim.keymap.set("n", "<leader>gpf", "<cmd>Octo pr changes<cr>", { desc = "List Changed Files" })
  vim.keymap.set("n", "<leader>gpd", "<cmd>Octo pr diff<cr>", { desc = "Show PR Diff" })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "octo",
    callback = function(ev)
      local opts = { buffer = ev.buf }
      vim.keymap.set("n", "<leader>gpc", "<nop>", vim.tbl_extend("force", opts, { desc = "+comments" }))
      vim.keymap.set("n", "<leader>gpca", "<cmd>Octo comment add<cr>", vim.tbl_extend("force", opts, { desc = "Add Comment" }))
      vim.keymap.set("n", "<leader>gpcd", "<cmd>Octo comment delete<cr>", vim.tbl_extend("force", opts, { desc = "Delete Comment" }))
      vim.keymap.set("n", "<leader>gpx", "<nop>", vim.tbl_extend("force", opts, { desc = "+reactions" }))
      vim.keymap.set("n", "<leader>gpx+", "<cmd>Octo reaction thumbs_up<cr>", vim.tbl_extend("force", opts, { desc = "👍" }))
      vim.keymap.set("n", "<leader>gpx-", "<cmd>Octo reaction thumbs_down<cr>", vim.tbl_extend("force", opts, { desc = "👎" }))
      vim.keymap.set("n", "<leader>gpxh", "<cmd>Octo reaction heart<cr>", vim.tbl_extend("force", opts, { desc = "❤️" }))
      vim.keymap.set("n", "<leader>gpxe", "<cmd>Octo reaction eyes<cr>", vim.tbl_extend("force", opts, { desc = "👀" }))
      vim.keymap.set("n", "<leader>gpxr", "<cmd>Octo reaction rocket<cr>", vim.tbl_extend("force", opts, { desc = "🚀" }))
      vim.keymap.set("n", "<leader>gpxl", "<cmd>Octo reaction laugh<cr>", vim.tbl_extend("force", opts, { desc = "😄" }))
      vim.keymap.set("n", "<leader>gpxp", "<cmd>Octo reaction hooray<cr>", vim.tbl_extend("force", opts, { desc = "🎉" }))
      vim.keymap.set("n", "<leader>gpxc", "<cmd>Octo reaction confused<cr>", vim.tbl_extend("force", opts, { desc = "😕" }))
      vim.keymap.set("n", "<leader>gpv", "<nop>", vim.tbl_extend("force", opts, { desc = "+review" }))
      vim.keymap.set("n", "<leader>gpvs", "<cmd>Octo review submit<cr>", vim.tbl_extend("force", opts, { desc = "Submit Review" }))
      vim.keymap.set("n", "<leader>gpvd", "<cmd>Octo review discard<cr>", vim.tbl_extend("force", opts, { desc = "Discard Review" }))
      vim.keymap.set("n", "<leader>gpvc", "<cmd>Octo review comments<cr>", vim.tbl_extend("force", opts, { desc = "Review Comments" }))
      vim.keymap.set("n", "<leader>gpvr", "<cmd>Octo review resume<cr>", vim.tbl_extend("force", opts, { desc = "Resume Review" }))
    end,
  })
end

return M
