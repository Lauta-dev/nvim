return {
	keymap = {
		preset = "default",

		["<Up>"] = false,
		["<Down>"] = false,
		["<CR>"] = { "select_and_accept", "fallback" }, -- Enter
		["<A-Up>"] = { "select_prev", "fallback" }, -- Alt+Up
		["<A-Down>"] = { "select_next", "fallback" }, -- Alt+Down
	},
	appearance = { nerd_font_variant = "mono" },

	completion = {
		menu = { border = "single" },
		documentation = {
			auto_show = true,
			window = { border = "single" },
		},
	},
	signature = {
		enabled = true,
		window = { border = "single" },
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	fuzzy = { implementation = "prefer_rust_with_warning" },
}
