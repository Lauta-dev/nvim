local set = vim.keymap.set
local buf = vim.lsp.buf
local cmd = vim.cmd
local telescope = require("telescope.builtin")

-- @param `estado` Estado del que esta el editor.
-- @param `tecla` Combinación de teclas que se pulsaran.
-- @param `accion` La acción a realizar.
local function normal_key(estado, tecla, accion)
  set(estado, "<" .. tecla .. ">", accion, { silent = true, noremap = true })
end

-- @param `estado` Estado del que esta el editor.
-- @param `tecla` Combinación de teclas que se pulsaran.
-- @param `accion` La acción a realizar.
local function space(estado, tecla, accion)
  set(estado, "<leader>" .. tecla, accion, { silent = true, noremap = true })
end

space("n", "s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Ver ayuda
space("n", "lh", buf.signature_help)

-- Simular un hover
space("n", "hh", buf.hover)

-- Ir a la definición de un método o funcion
space("n", "ll", buf.definition)

-- Uso de rest
space("n", "e", "<Plug>RestNvim")

-- Ver el dianostico
normal_key("n", "C-l", vim.diagnostic.open_float)

normal_key("n", "C-s", ":w!<CR>") -- Guardar los cambios
space("n", "xx", ":q!<CR>")       -- Cerrar el archivo sin guardar

-- Explorador de archivos
normal_key("n", "C-b", cmd.NvimTreeToggle) -- Abrir y cierra

-- buffers
normal_key("n", "S-l", cmd.BufferLineCycleNext) -- Ir al siguiente buffer
normal_key("n", "S-k", cmd.BufferLineCyclePrev) -- Ir al buffer anterior
normal_key("n", "C-c", cmd.bd)                  -- Cerrar el buffer (Cerrar el fichero)

-- Mover la linea
normal_key("n", "S-C-Up", function() cmd.m("-2") end)
normal_key("n", "S-C-Down", function() cmd.m("+1") end)

-- Crear nuevo archivo
normal_key("n", "C-n", cmd.new)

-- Mover el cursor de una ventana a otra
normal_key("n", "A-Down", ":wincmd j<CR>")
normal_key("n", "A-Up", ":wincmd k<CR>")
normal_key("n", "A-Left", ":wincmd h<CR>")
normal_key("n", "A-Right", ":wincmd l<CR>")

normal_key("t", "A-Down", "<cmd>wincmd j<CR>]]")
normal_key("t", "A-Up", "<cmd>wincmd k<CR>]]")
normal_key("t", "A-Left", "<cmd>wincmd h<CR>]]")
normal_key("t", "A-Right", "<cmd>wincmd l<CR>]]")

-- Copiar texto al portapapeles (en Linux se necesita xclip)
normal_key("n", "y", '"+y')
normal_key("n", "p", '"+p')

-- terminal
normal_key("n", "C-j", cmd.ToggleTerm)
normal_key('t', 'C-j', [[<Cmd>ToggleTerm<CR>]])

-- Renombrar variables
normal_key("n", "C-p", buf.rename)

-- Telescope
local telescope_preview = {
  find_files = true,
  buffers = true,
  lsp_references = true,
  git_files = true
}

space("n", "ff", function()
  telescope.find_files({ previewer = telescope_preview.find_files })
end)

space("n", "fg", function()
  telescope.git_files({ previewer = telescope_preview.git_files })
end)

space("n", "fb", function()
  telescope.buffers({ previewer = telescope_preview.buffers })
end)

space("n", "fr", function()
  telescope.lsp_references({ previewer = telescope_preview.lsp_references })
end)

space("n", "ft", cmd.TodoTelescope)
