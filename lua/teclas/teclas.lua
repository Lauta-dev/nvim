local key_map = vim.keymap.set

local function use_normal_key(estado, tecla, accion)
	key_map(estado, "<" .. tecla .. ">", accion, { silent = true, noremap = true })
end

local function use_key_space(estado, tecla, accion)
	key_map(estado, "<leader>" .. tecla, accion, { silent = true, noremap = true })
end

-- Ver el dianostico
use_normal_key("n", "C-l", vim.diagnostic.open_float)

use_normal_key("n", "C-s", ":w!<CR>") -- Guardar los cambios
use_normal_key("n", "C-x", ":q!<CR>") -- Cerrar el archivo sin guardar

-- Explorador de archivos
use_normal_key("n", "C-b", ":Neotree toggle<CR>") -- Abrir y cierra
use_key_space("n", "v", ":Neotree focus<CR>") -- Mueve el cursor al explorador de archivos

-- buffers
use_normal_key("n", "S-l", ":BufferLineCycleNext<CR>") -- Ir al siguiente buffer
use_normal_key("n", "S-k", ":BufferLineCyclePrev<CR>") -- Ir al buffer anterior
use_normal_key("n", "C-c", ":bd<CR>") -- Cerrar el buffer (Cerrar el fichero)

-- Crear nuevo archivo
use_normal_key("n", "C-n", ":new<CR>")

-- Pasar el cursor de una ventana a otra
use_normal_key("n", "C-A-Up", ":wincmd k<CR>")
use_normal_key("n", "C-A-Down", ":wincmd j<CR>")
use_normal_key("n", "C-A-Left", ":wincmd h<CR>")
use_normal_key("n", "C-A-Right", ":wincmd l<CR>")

-- Copiar texto al portapapeles (en Linux se necesita xclip)
use_normal_key("n", "y", '"+y')
use_normal_key("n", "p", '"+p')

-- terminal
use_normal_key("n", "C-j", ":ToggleTerm<CR>")
use_normal_key("t", "C-j", ":wincdmd ToggleTerm<CR>")

-- Renombrar variables
use_normal_key("n", "C-p", '<cmd>lua require("renamer").rename()<cr>')

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
use_key_space("n", "ff", ":Telescope find_files<CR>")
use_key_space("n", "fb", ":Telescope buffers<CR>")
use_key_space("n", "cs", ":Telescope colorscheme<CR>")
