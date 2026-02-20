return {
	flavour = "mocha",
	transparent_background = false,
	term_colors = true,
	integrations = {
		blink_cmp = true,
		gitsigns = true,
		indent_blankline = { enabled = true },
		mason = true,
		mini = { enabled = true },
		nvimtree = false, -- using snacks explorer
		telescope = { enabled = false },
		treesitter = true,
		fidget = true,
		native_lsp = {
			enabled = true,
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
	},
	compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
}
