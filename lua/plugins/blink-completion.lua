-- blink-completion.lua
return {
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "v0.*",
		opts = {
			keymap = {
				preset = "default",
				-- Custom key mappings
				["<C-n>"] = { "select_next" },
				["<C-N>"] = { "select_prev" },
				-- Disable key maps that I don't like
				["<Up>"] = {},
				["<Down>"] = {},
				["<C-p>"] = {},
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				list = {
					-- set to preselect, manual or auto_insert
					selection = { preselect = false, auto_insert = false },
				},
				ghost_text = {
					enabled = true,
				},
			},
			signature = { enabled = true },
			sources = {
				-- `lsp`, `buffer`, `snippets`, `path` and `omni` are built-in
				-- so you don't need to define them in `sources.providers`
				default = { "lsp", "buffer", "snippets", "path" },
			},
		},
	},
}
