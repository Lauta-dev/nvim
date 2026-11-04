local map = vim.keymap.set
local buf = vim.lsp.buf
local cmd = vim.cmd

local keys = {
	{
		"rr",
		function()
			cmd.restart()
		end,
		desc = "Reiniciar sessión",
	},
	{
		"ft",
		function()
			require("lazy").load({ plugins = { "todo-comments.nvim" } })
			require("snacks.picker")["todo_comments"]()
		end,
		desc = "Buscar TODOs",
	},
	{
		"e",
		function()
			Snacks.picker.explorer()
		end,
		desc = "Abrir Explorador",
	},

	{
		"ff",
		function()
			Snacks.picker.files()
		end,
		desc = "Buscar archivos",
	},
	{
		"fb",
		function()
			Snacks.picker.buffers()
		end,
		desc = "Buscar buffers",
	},
	{
		"fg",
		function()
			Snacks.picker.grep()
		end,
		desc = "Buscar texto",
	},
	{
		"fr",
		function()
			Snacks.picker.lsp_references()
		end,
		desc = "Referencias",
	},
	{
		"fp",
		function()
			Snacks.picker.projects()
		end,
		desc = "Proyectos",
	},
	{
		"fk",
		function()
			Snacks.picker.keymaps()
		end,
		desc = "Buscar atajos",
	},
	{
		"tf",
		function()
			Snacks.terminal.toggle()
		end,
		desc = "Terminal flotante",
	},

	{
		"nh",
		function()
			require("snacks").notifier.show_history()
		end,
		desc = "Notification History",
	},

	{ "gd", buf.definition, "Ir a la definición" },
	{ "gh", buf.hover, "Hacer hover" },
	{ "sh", buf.signature_help, "Mostrar ayuda" },

	{
		"s",
		[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
		"Sustituir la palabra bajo el cursor en todo el buffer",
	},

	{ "<C-x>", ":x <CR>", "Guarda buffer y sale de Neovim" },
	{ "<C-q>", ":q <CR>", "Sale de Neovim sin guardar buffer" },
	{ "<C-s>", ":w!<CR>", "Guardar cambios" },

	{
		"<C-r>",
		"<C-r>",
		"Devuelve lineas eliminadas (Es lo contrario a 'u')",
	},
	{ "<C-u>", "u", "Elimina lineas puestas (Es la acción de 'u')" },

	{ "<C-d>", vim.diagnostic.open_float, "Ver diagnostico" },
	{ "<C-n>", cmd.new, "Crear nuevo buffer" },
	{ "<C-c>", cmd.bd, "Cerrar buffer" },
	{ "<C-p>", buf.rename, "Renombrar variables/Función" },

	{
		"<A-Up>",
		function()
			cmd.m("-2")
		end,
		"Mueve la linea arriba",
	},
	{
		"<A-Down>",
		function()
			cmd.m("+1")
		end,
		"Mueve la linea abajo",
	},

	{ "y", '"+y', "Copiar al portapapeles" },
	{ "p", '"+p', "Pegar desde el portapapeles" },
	{ "<C-Left>", "<C-w>h", "Ir a la izq" },
	{ "<C-Right>", "<C-w>l", "Ir a la der" },
	{ "<C-Down>", "<C-w>j", "Ir abajo" },
	{ "<C-Up>", "<C-w>k", "asd" },
}

for _, k in ipairs(keys) do
	map(k[4] or "n", k[1], k[2], { desc = k[3] })
end

local function my_keymaps()
	local items = {}
	local max = 10

	for _, k in ipairs(keys) do
		local space = " "
		local n = max - #k[1]

		for _ = 1, n do
			space = space .. " "
		end

		table.insert(items, {
			text = k[1] .. space .. (k.desc or k[3] or ""),
			key = k[1],
			desc = k.desc or k[3],
			action = k[2],
		})
	end

	Snacks.picker({
		items = items,
		format = function(item)
			return {
				{ item.text, "SnacksPickerLabel" },
			}
		end,
		layout = {
			layout = {
				width = 0.8,
				height = 0.8,
				min_width = 30,
				min_height = 20,
				box = "vertical",
				border = true,
				title = "Mis Keymaps",
				{ win = "input", height = 1, border = "bottom" },
				{ win = "list", border = "none" },
			},
		},
		confirm = function(picker, item)
			picker:close()

			if type(item.action) == "function" then
				item.action()
			elseif type(item.action) == "string" then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(item.action, true, false, true), "m", false)
			end
		end,
	})
end

map("n", "fk", my_keymaps, { desc = "Mostrar mis atajos" })

-- Insert mode Right fluido
vim.keymap.set("i", "<Right>", function()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0)) -- fila, columna (0-indexed)
	local line = vim.api.nvim_get_current_line()
	local line_len = #line

	if col >= line_len and row < vim.fn.line("$") then
		-- saltar a la siguiente línea al inicio
		vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
	else
		-- moverse normalmente a la derecha
		feedkey = vim.api.nvim_replace_termcodes("<Right>", true, false, true)
		vim.api.nvim_feedkeys(feedkey, "n", true)
	end
end, { noremap = true, silent = true })

-- Insert mode Left fluido
vim.keymap.set("i", "<Left>", function()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()

	if col == 0 and row > 1 then
		-- saltar a la línea anterior al final
		local prev_line_len = #vim.api.nvim_buf_get_lines(0, row - 2, row - 1, false)[1]
		vim.api.nvim_win_set_cursor(0, { row - 1, prev_line_len })
	else
		feedkey = vim.api.nvim_replace_termcodes("<Left>", true, false, true)
		vim.api.nvim_feedkeys(feedkey, "n", true)
	end
end, { noremap = true, silent = true })

-- Normal mode Right
vim.keymap.set("n", "<Right>", function()
	local col = vim.fn.col(".")
	local line_len = math.max(vim.fn.col("$") - 1, 1) -- asegura al menos 1
	local current_line = vim.fn.line(".")
	local max_line = vim.fn.line("$")

	if col >= line_len and current_line < max_line then
		vim.cmd("normal! j0") -- bajar línea e ir al inicio
	else
		vim.cmd("normal! l")
	end
end, { noremap = true, silent = true })

-- Normal mode Left
vim.keymap.set("n", "<Left>", function()
	local col = vim.fn.col(".")
	local current_line = vim.fn.line(".")

	if col == 1 and current_line > 1 then
		vim.cmd("normal! k$") -- subir línea e ir al final
	else
		vim.cmd("normal! h")
	end
end, { noremap = true, silent = true })
