local set = vim.keymap.set
local buf = vim.lsp.buf
local cmd = vim.cmd
local telescope = require("telescope.builtin")

NVIM_STATES = {
	normal = "n",
	terminal = "t",
}

local telescope_preview = {
	find_files = true,
	buffers = true,
	lsp_references = true,
	git_files = true,
}

-- @param `state` Estado del que esta el editor.
-- @param `key` Combinación de teclas que se pulsaran.
-- @param `action' La acción a realizar.
local function normal_key(state, key, action)
	set(state, "<" .. key .. ">", action, { silent = true, noremap = true })
end

-- @param `state` Estado del que esta el editor.
-- @param `key` Combinación de teclas que se pulsaran.
-- @param `action` La acción a realizar.
local function space(state, key, action)
	set(state, "<leader>" .. key, action, { silent = true, noremap = true })
end

local space_keys = {
	{
		desc = "Go to definition of method or function",
		state = NVIM_STATES.normal,
		key = "ll",
		action = buf.definition,
	},
	{
		desc = "",
		state = NVIM_STATES.normal,
		key = "hh",
		action = buf.hover,
	},
	{
		state = NVIM_STATES.normal,
		key = "lh",
		action = buf.signature_help,
	},
	{
		state = NVIM_STATES.normal,
		key = "e",
		action = ":NvimTreeFocus<CR>",
	},
	{
		state = NVIM_STATES.normal,
		key = "ff",
		action = ":Telescope find_files<CR>",
	},
	{
		state = NVIM_STATES.normal,
		key = "fg",
		action = ":Telescope git_files<CR>",
	},
	{
		state = NVIM_STATES.normal,
		key = "fb",
		action = ":Telescope buffers<CR>",
	},
	{
		state = NVIM_STATES.normal,
		key = "fr",
		action = ":Telescope lsp_references<CR>",
	},
	{
		state = NVIM_STATES.normal,
		key = "ft",
		action = cmd.TodoTelescope,
	},
	{
		state = NVIM_STATES.normal,
		key = "s",
		action = [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	},
}

-- Atajos usando Control
local normal_keys = {
	{
		desc = "View diagnostic",
		state = NVIM_STATES.normal,
		key = "C-l",
		action = vim.diagnostic.open_float,
	},
	{
		desc = "Open file explorer",
		state = NVIM_STATES.normal,
		key = "C-b",
		action = ":NvimTreeToggle<CR>",
	},
	{
		desc = "Save file",
		state = NVIM_STATES.normal,
		key = "C-s",
		action = ":w!<CR>",
	},

	{
		desc = "Next buffer",
		state = NVIM_STATES.normal,
		key = "S-l",
		action = cmd.BufferLineCycleNext,
	},
	{
		desc = "Prev buffer",
		state = NVIM_STATES.normal,
		key = "S-k",
		action = cmd.BufferLineCyclePrev,
	},
	{
		desc = "Close buffer",
		state = NVIM_STATES.normal,
		key = "C-c",
		action = cmd.bd,
	},

	{
		desc = "Move line - up",
		state = NVIM_STATES.normal,
		key = "S-C-Up",
		action = function()
			cmd.m("-2")
		end,
	},
	{
		desc = "Move line - down",
		state = NVIM_STATES.normal,
		key = "C-c",
		action = cmd.bd,
	},
	{
		desc = "Create new file",
		state = NVIM_STATES.normal,
		key = "C-n",
		action = cmd.new,
	},

	{
		desc = "Copy line to clipboard",
		state = NVIM_STATES.normal,
		key = "y",
		action = '"+y',
	},
	{
		desc = "Paste from clipboard",
		state = NVIM_STATES.normal,
		key = "p",
		action = '"+p',
	},

	{
		desc = "Open terminal",
		state = NVIM_STATES.normal,
		key = "C-j",
		action = cmd.ToggleTerm,
	},
	{
		desc = "Close terminal",
		state = NVIM_STATES.terminal,
		key = "C-j",
		action = [[<Cmd>ToggleTerm<CR>]],
	},

	{
		desc = "rename variables",
		state = NVIM_STATES.normal,
		key = "C-p",
		action = buf.rename,
	},
}

for _, obj in ipairs(space_keys) do
	space(obj.state, obj.key, obj.action)
end

for _, obj in ipairs(normal_keys) do
	normal_key(obj.state, obj.key, obj.action)
end

-- Mover el cursor de una ventana a otra
--[[normal_key("n", "A-Down", ":wincmd j<CR>")
normal_key("n", "A-Up", ":wincmd k<CR>")
normal_key("n", "A-Left", ":wincmd h<CR>")
normal_key("n", "A-Right", ":wincmd l<CR>")--]]

--normal_key("t", "A-Down", "<cmd>wincmd j<CR>]]")
--normal_key("t", "A-Up", "<cmd>wincmd k<CR>]]")
--normal_key("t", "A-Left", "<cmd>wincmd h<CR>]]")
--normal_key("t", "A-Right", "<cmd>wincmd l<CR>]]")
