# Plugin Review

This document summarizes the current plugin modules under `lua/plugins` and records the current keymap/which-key audit status.

## Current Plugin Summary

| File | Current Use | Primary Keymaps |
| --- | --- | --- |
| `lua/plugins/blink-completion.lua` | Completion via `blink.cmp` with friendly snippets, ghost text, and signature help. | None declared here. |
| `lua/plugins/buff-as-tabs.lua` | Bufferline-based tab-style buffer navigation with diagnostics. | `<S-h>`, `<S-l>`, `[b`, `]b` |
| `lua/plugins/codesnap.lua` | On-demand code screenshot export to the clipboard without loading CodeSnap at startup. | `<leader>cs`, `<leader>cS` |
| `lua/plugins/conform.lua` | Formatting through `conform.nvim`, with save-time formatting constrained to changed hunks. | `<leader>cf`, `<leader>cF` |
| `lua/plugins/fzf-lua.lua` | Main picker and navigation surface for files, grep, marks, help, document symbols, and LSP jumps/call hierarchies. | `<leader>f*`, `<leader>s*`, `<leader>l*`, `g*` |
| `lua/plugins/glyphs.lua` | Window-local text-to-glyph conceal rules that show in normal/visual mode and drop back to raw text in insert mode. | `<leader>u`, `<leader>ug`, `:GlyphsToggle` |
| `lua/plugins/inline-diagnostics.lua` | Inline diagnostics rendering with virtual text disabled. | None declared here. |
| `lua/plugins/lazygit.lua` | Dedicated floating Lazygit integration, restored as its own plugin instead of relying on Snacks' wrapper. | `<leader>g*` |
| `lua/plugins/lisp.lua` | Local Lisp development support via Conjure REPL/eval workflow plus Fennel filetype support, all namespaced under a dedicated leader prefix. | `<leader>k*` |
| `lua/plugins/lualine.lua` | Statusline with mode, branch, diff, diagnostics, progress, and macro recording. Top winbar breadcrumbs are no longer used. | None declared here. |
| `lua/plugins/mason.lua` | Mason-based installation and setup of LSP servers and formatter/linter tools. | None declared here. |
| `lua/plugins/mini.lua` | `mini.diff`, `mini.comment`, `mini.icons`, and `mini.pairs` configuration. | `<leader>go` |
| `lua/plugins/noice.lua` | `noice.nvim` with default UI routing. | None declared here. |
| `lua/plugins/nvim-lint.lua` | Buffer/event-driven linting with filetype-specific linters plus cspell coverage. | None declared here. |
| `lua/plugins/octo.lua` | GitHub PR/review workflow via Octo, including PR listing, checkout, diff, comments, reactions, and review actions. | `<leader>gp*` |
| `lua/plugins/overseer.lua` | Task runner setup via Overseer. | None declared here. |
| `lua/plugins/pi.lua` | Lightweight Pi agent integration for buffer/selection prompts, cancellation, and log inspection. | `<leader>j*` |
| `lua/plugins/preview.lua` | Preview tooling for Typst, CSV, Markdown/browser preview, and OmniPreview. | `<leader>p`, `<leader>po`, `<leader>pc` |
| `lua/plugins/rainbow-delimiters.lua` | Nested delimiter coloring. | None declared here. |
| `lua/plugins/render-markdown.lua` | Markdown rendering/toggle controls with anti-conceal helpers. | `<leader>m*` |
| `lua/plugins/snacks.lua` | Utility surface for dashboard, scratch buffers, zen mode, profiler, git blame, code actions, rename, and editor niceties that do not overlap with the dedicated picker stack. | `<leader>g*`, `<leader>l*`, `<leader>d*`, `<leader>z*`, `<leader>b*`, `<leader>c*` |
| `lua/plugins/theme.lua` | Kanagawa colorscheme plus custom highlight overrides. | None declared here. |
| `lua/plugins/treesitter.lua` | Tree-sitter syntax/highlighting, incremental selection, sticky context, and explicit parser management for the added Lisp-family languages without opportunistic auto-installs. | `<CR>`, `<S-CR>`, `<BS>` |
| `lua/plugins/which-key.lua` | Which-key setup and documentation/triggers for keybinding discovery. | `<leader>?` |
| `lua/plugins/yazi.lua` | File manager integration through Yazi. | `<leader>e` |

## Keymap Audit

- Leader-prefix categories now exist for the currently nested plugin bindings that were missing them: `<leader>u`, `<leader>am`, and `<leader>ar`.
- The new Lisp namespace is documented with dedicated category noops for `<leader>k`, `<leader>kc`, and `<leader>kl`, so Conjure's leader-based mappings remain discoverable without colliding with the existing space localleader.
- The Pi namespace now lives under `<leader>j`, with `<leader>j` acting as the category prefix for prompt, cancel, and log actions.
- The code prefix category now exists in both normal and visual mode, so visual mappings like `<leader>cs`, `<leader>cS`, `<leader>cf`, and `<leader>cF` are grouped correctly.
- Git tooling is grouped under `<leader>g*`: Lazygit stays on `<leader>gg` / `<leader>gf`, git blame stays on `<leader>gb`, and Octo PR/review bindings now sit under `<leader>gp*`.
- Snacks profiler scratch no longer lives in the preview namespace; it now sits under a dedicated `<leader>d*` debug prefix.
- The picker/LSP jump surface has moved from `Snacks.picker` to `fzf-lua`.
- Which-key is no longer limited to leader-only discovery. It now also documents prefixed `g`, `[`, and `]` mappings, and includes virtual labels for the Tree-sitter incremental selection keys.

## Open Review Findings

1. `lua/plugins/conform.lua`: `format_changed_lines()` collects all modified hunks but only passes `ranges[1]` to `conform.format()`, so only the first changed hunk is formatted on save.
2. `lua/plugins/noice.lua`: `require("noice").setup({})` enables bare defaults. That is valid, but it should be checked against the rest of the UI stack to confirm those defaults are actually wanted.
3. `lua/plugins/treesitter.lua`: `nvim-treesitter` is now archived upstream. The config is safer with explicit parser lists and `auto_install = false`, but long-term maintenance still depends on staying on this frozen stack or replacing it later with a different maintained query/parser workflow.
4. `lua/plugins/lisp.lua`: Conjure has been moved under `<leader>k` to avoid the existing `maplocalleader = " "` collision. This keeps the keymap surface coherent, but it does intentionally diverge from Conjure's default `<localleader>` workflow.

## Global Non-Plugin Keymap

- `lua/config/keymaps.lua`: `<leader>lh` toggles LSP inlay hints.
- `lua/config/lsp.lua`: `<M-o>` switches between header and source files when `clangd` attaches.
