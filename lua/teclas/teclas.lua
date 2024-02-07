local function map(estado, tecla, accion)
	vim.keymap.set(estado, "<" .. tecla .. ">", accion, { silent = true, noremap = true })
end

local function espacio(estado, tecla, accion)
	vim.keymap.set(estado, "<leader>" .. tecla, accion, { silent = true, noremap = true })
end

-- Ver el dianostico
map("n", "C-l", vim.diagnostic.open_float)

-- Ver priview de un archivo markdown
espacio("n", "m", ":Glow")

-- Rest http
map("n", "C-m", "<Plug>RestNvim")

-- key <leader>
vim.g.mapleader = " "

map("n", "C-s", ":w!<CR>")
map("n", "C-x", ":q!<CR>")

-- file explorer
map("n", "C-b", ":Neotree toggle<CR>")
espacio("n", "v", ":Neotree focus<CR>")

-- buffers
map("n", "S-l", ":BufferLineCycleNext<CR>")
map("n", "S-k", ":BufferLineCyclePrev<CR>")
map("n", "C-w", ":bd<CR>")

-- copy text
map("n", "y", '"+y')
map("n", "p", '"+p')

-- terminal
map("n", "C-j", ":ToggleTerm<CR>")
map("t", "C-j", ":wincdmd ToggleTerm<CR>")

-- Renombrar variables
map("n", "C-p", '<cmd>lua require("renamer").rename()<cr>')

local api = require("Comment.api")
--vim.keymap.set("n", "gc", api.call("toggle.linewise", "g@"), { expr = true })
vim.keymap.set("n", "<C-.>", api.call("toggle.linewise", "g@$"), { expr = true })

-- Formatear texto al guardar
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})

-- Telescope
espacio("n", "ff", ":Telescope find_files<CR>")
espacio("n", "fb", ":Telescope buffers<CR>")
espacio("n", "cs", ":Telescope colorscheme<CR>")
