return {
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },

		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,

		disabled_filetypes = {
			"alpha",
			"NvimTree",
			"Dashboard",
			"Telescope",
			"Neotree",
			"neo-tree",
			"Rest",
			"rest",
			"ToogleTerm",
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "brach", "diff", "diagnostics" },
		lualine_x = {},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
}
