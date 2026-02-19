local header = [[
 ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
 ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]

return {
	-- Big file protection
	bigfile = { enabled = true, size = 1.5 * 1024 * 1024 },

	-- Dashboard
	dashboard = {
		enabled = true,
		preset = {
			header = header,
			keys = {
				{
					icon = " ",
					key = "f",
					desc = "Find File",
					action = function()
						require("snacks").picker.files()
					end,
				},
				{
					icon = " ",
					key = "g",
					desc = "Live Grep",
					action = function()
						require("snacks").picker.grep()
					end,
				},
				{
					icon = " ",
					key = "r",
					desc = "Recent",
					action = function()
						require("snacks").picker.recent()
					end,
				},
				{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
	},

	-- Picker (replaces Telescope entirely)
	picker = {
		enabled = true,
		ui_select = true, -- replaces vim.ui.select
		sources = {
			explorer = {
				-- Snacks file-tree explorer
				hidden = true,
				ignore = true,
			},
		},
		win = {
			input = {
				keys = {
					["<Esc>"] = { "close", mode = { "i", "n" } },
				},
			},
		},
	},

	-- Explorer sidebar
	explorer = { enabled = true },

	-- Indent guides (replaces indent-blankline for speed)
	indent = {
		enabled = true,
		animate = { enabled = false },
		scope = { enabled = true },
		chunk = { enabled = false },
	},

	input = { enabled = true },
	notifier = { enabled = true, timeout = 3000, style = "compact" },
	quickfile = { enabled = true }, -- fast open for big files
	scroll = { enabled = false }, -- skip scroll animations for perf
	statuscolumn = { enabled = true },
	words = { enabled = true },
}
