return {
	options = {
		theme = "auto",
		disabled_filetypes = {
			"alpha",
			"NvimTree",
			"Dashboard",
			"Telescope",
			"Neotree",
			"neo-tree",
			"Rest",
			"rest",
		},
		options = { section_separators = "", component_separators = "" },
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "brach", "diff", "diagnostics" },
			lualine_x = {},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
