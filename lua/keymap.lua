local map = vim.keymap.set
local buf = vim.lsp.buf
local cmd = vim.cmd

---@param key string Combinación de teclas que se pulsaran.
---@param action string La acción a realizar.
---@param desc string Descripción.
local function normalKey(key, action, desc)
	map("n", "<" .. key .. ">", action, { desc = desc, silent = true, noremap = true })
end

---@param key string Combinación de teclas que se pulsaran.
---@param action string La acción a realizar.
---@param desc string Descripción.
local function spaceKey(key, action, desc)
	map("n", key, action, { desc = desc, silent = true, noremap = true })
end

---@param picker string picker
local function pickers(picker)
	require("snacks.picker")[picker]()
end

---@param g string Appps generales
local function general_app(g)
	local req = require("snacks")

	if g == "explorer" then
		req.explorer()
	end

	if g == "terminal" then
		req.terminal.toggle()
	end

	if g == "lazygit" then
		req.lazygit()
	end
end

-- Atajos usando tecla espaciadora
local space_keys = {
	{ key = "gd", action = buf.definition, desc = "Ir a la definición" },
	{ key = "gh", action = buf.hover, desc = "Hacer hover" },
	{ key = "sh", action = buf.signature_help, desc = "Mostrar ayuda" },
	{
		key = "ft",
		-- action = cmd.TodoTelescope,
		action = function()
			pickers("todo_comments")
		end,
		desc = "Abrir telescope para buscar TODO",
	},

	{
		key = "e",
		action = function()
			general_app("explorer")
		end,
		desc = "Mover el cursor al file explorer",
	},

	{
		key = "ff",
		action = function()
			pickers("files")
		end,
		desc = "Abrir telescope para buscar archivos",
	},
	{
		key = "fb",
		action = function()
			pickers("buffers")
		end,
		desc = "Abrir telescope para buscar buffers",
	},
	{
		key = "fr",
		action = function()
			pickers("lsp_references")
		end,
		desc = "Abrir telescope para buscar referencias",
	},
	{
		key = "fg",
		action = function()
			pickers("grep")
		end,
		desc = "Abrir telescope para buscar caracteres",
	},
	{
		key = "fp",
		action = function()
			pickers("projects")
		end,
		desc = "Buscar proyectos",
	},
	{
		key = "s",
		action = [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
		desc = "Sustituir la palabra bajo el cursor en todo el buffer",
	},

	{
		key = "tf",
		action = function()
			general_app("terminal")
		end,
		desc = "Abrir terminal flotante",
	},
	{
		key = "tg",
		action = function()
			general_app("lazygit")
		end,
		desc = "Abrir Lazygit",
	},
}

-- Atajos usando Control
local normal_keys = {
	{ key = "C-x", action = ":x <CR>", desc = "Guarda buffer y sale de Neovim" },
	{ key = "C-q", action = ":q <CR>", desc = "Sale de Neovim sin guardar buffer" },
	{ key = "C-s", action = ":w!<CR>", desc = "Guardar cambios" },

	{
		key = "C-r",
		action = "<C-r>",
		desc = "Devuelve lineas eliminadas (Es lo contrario a 'u')",
	},
	{ key = "C-u", action = "u", desc = "Elimina lineas puestas (Es la acción de 'u')" },

	{ key = "C-d", action = vim.diagnostic.open_float, desc = "Ver diagnostico" },
	-- { key = "C-b",    action = function() Snacks.explorer() end, desc = "Abrir file explorer" },

	{ key = "C-n", action = cmd.new, desc = "Crear nuevo buffer" },
	{ key = "C-c", action = cmd.bd, desc = "Cerrar buffer" },
	{ key = "C-p", action = buf.rename, desc = "Renombrar variables/Función" },

	{
		key = "A-Up",
		action = function()
			cmd.m("-2")
		end,
		desc = "Mueve la linea arriba",
	},
	{
		key = "A-Down",
		action = function()
			cmd.m("+1")
		end,
		desc = "Mueve la linea abajo",
	},

	{ key = "y", action = '"+y', desc = "Copiar al portapapeles" },
	{ key = "p", action = '"+p', desc = "Pegar desde el portapapeles" },
}

for _, obj in ipairs(space_keys) do
	spaceKey(obj.key, obj.action, obj.desc)
end

for _, obj in ipairs(normal_keys) do
	normalKey(obj.key, obj.action, obj.desc)
end
local all_keys = vim.list_extend(vim.deepcopy(space_keys), normal_keys)

-- calcular ancho máximo de las keys
local max_key_len = 0
for _, e in ipairs(all_keys) do
	max_key_len = math.max(max_key_len, #e.key)
end

-- crear items con padding uniforme
local items = vim.tbl_map(function(e)
	local padding = string.rep(" ", max_key_len - #e.key + 2) -- +2 para separar
	return {
		text = e.key .. padding .. e.desc,
		action = e.action,
		desc = e.desc,
	}
end, all_keys)

map("n", "fk", function()
	Snacks.picker.pick({
		title = "Atajos",
		layout = { preset = "default", preview = false },
		items = items,
		format = function(item)
			return { { item.text } }
		end,

		confirm = function(picker, item)
			picker:close()
			if type(item.action) == "function" then
				item.action()
			elseif type(item.action) == "string" then
				if vim.startswith(item.action, ":") and not item.action:find("<") then
					-- Si empieza con ":" y no contiene <teclas>, es un comando ex
					vim.cmd(item.action:sub(2))
				else
					-- Sino, lo tratamos como entrada de teclado
					vim.api.nvim_input(vim.api.nvim_replace_termcodes(item.action, true, true, true))
				end
			end
		end,
	})
end, { desc = "Abrir picker de atajos" })

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Dehabilitar tecla "u" que esta por defecto

map("n", "u", "<Nop>", { noremap = true, silent = true })

----------------------------------------

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
