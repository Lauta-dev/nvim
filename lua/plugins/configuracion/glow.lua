require("glow").setup({
	border = "none", -- floating window border config
	style = "dark", -- filled automatically with your current editor background, you can override using glow json style
	pager = false,
	width = 150,
	height = 150,
	width_ratio = 1, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
	height_ratio = 1,
})
