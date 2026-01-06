return {
	content = { -- ← Faltaba este nivel
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 100 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })
			local filetype = vim.bo.filetype
			local filename = vim.fn.expand("%:t") -- Solo el nombre del archivo
			if filename == "" then
				filename = ""
			end

			local function custom_location()
				local line = vim.fn.line(".")
				local col = vim.fn.col(".")
				local total_lines = vim.fn.line("$")

				-- Formato personalizado: línea:columna
				return string.format("󰍉 %d:%d", line, col)
			end
			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git } },
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=", -- End left alignment
				{ hl = "MiniStatuslineFileinfo", strings = { filetype } },
				{ hl = mode_hl, strings = { custom_location() } },
			})
		end,
		inactive = nil,
	},
	use_icons = true, -- También puedes agregar esta opción
}
