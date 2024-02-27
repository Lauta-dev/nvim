local key_map = vim.keymap.set
local lsp_buf = vim.lsp.buf

-- @param estado Estado del que esta el editor.
-- @param tecla Combinación de teclas que se pulsaran.
-- @param accion La acción a realizar.
local function use_normal_key(estado, tecla, accion)
	key_map(estado, "<" .. tecla .. ">", accion, { silent = true, noremap = true })
end

-- @param estado Estado del que esta el editor.
-- @param tecla Combinación de teclas que se pulsaran.
-- @param accion La acción a realizar.
local function use_key_space(estado, tecla, accion)
	key_map(estado, "<leader>" .. tecla, accion, { silent = true, noremap = true })
end

-- Ver ayuda
use_key_space("n", "lh", lsp_buf.signature_help)

-- Simular un hover
use_key_space("n", "hh", lsp_buf.hover)

-- Ir a la definición de un método o funcion
use_key_space("n", "ll", vim.lsp.buf.definition)

-- Uso de rest
use_key_space("n", "ee", "<Plug>RestNvim")

-- Ver el dianostico
use_normal_key("n", "C-l", vim.diagnostic.open_float)

use_normal_key("n", "C-s", ":w!<CR>") -- Guardar los cambios
use_key_space("n", "xx", ":q!<CR>") -- Cerrar el archivo sin guardar

-- Explorador de archivos
use_normal_key("n", "C-b", ":NvimTreeToggle <CR>") -- Abrir y cierra
use_key_space("n", "v", ":NvimTreeFocus <CR>") -- Mueve el cursor al explorador de archivos

-- buffers
use_normal_key("n", "S-l", ":BufferLineCycleNext<CR>") -- Ir al siguiente buffer
use_normal_key("n", "S-k", ":BufferLineCyclePrev<CR>") -- Ir al buffer anterior
use_normal_key("n", "C-c", ":bd<CR>") -- Cerrar el buffer (Cerrar el fichero)

-- Mover la linea
use_normal_key("n", "S-C-Up", ":m -2<CR>")
use_normal_key("n", "S-C-Down", ":m +1<CR>")

-- Crear nuevo archivo
use_normal_key("n", "C-n", ":new<CR>")

-- Pasar el cursor de una ventana a otra
--use_normal_key("n", "C-A-Up", ":wincmd k<CR>")
--use_normal_key("n", "C-A-Down", ":wincmd j<CR>")
--use_normal_key("n", "C-A-Left", ":wincmd h<CR>")
--use_normal_key("n", "C-A-Right", ":wincmd l<CR>")

-- Copiar texto al portapapeles (en Linux se necesita xclip)
use_normal_key("n", "y", '"+y')
use_normal_key("n", "p", '"+p')

-- terminal
use_normal_key("n", "C-j", ":ToggleTerm<CR>")
use_normal_key("t", "C-j", ":wincdmd ToggleTerm<CR>")

-- Renombrar variables
use_normal_key("n", "C-p", vim.lsp.buf.rename)

-- Formatear texto al guardar
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	--command = ":lua vim.lsp.buf.format()",
	command = ":FormatWrite",
})

-- Telescope
use_key_space("n", "ff", ":Telescope find_files<CR>")
use_key_space("n", "fb", ":Telescope buffers<CR>")
use_key_space("n", "fr", ":Telescope lsp_references<CR>")
