local set = vim.keymap.set
local buf = vim.lsp.buf
local cmd = vim.cmd
local telescope = require("telescope.builtin")

-- @param estado Estado del que esta el editor.
-- @param tecla Combinación de teclas que se pulsaran.
-- @param accion La acción a realizar.
local function normal_key(estado, tecla, accion)
  set(estado, "<" .. tecla .. ">", accion, { silent = true, noremap = true })
end

-- @param estado Estado del que esta el editor.
-- @param tecla Combinación de teclas que se pulsaran.
-- @param accion La acción a realizar.
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
--normal_key("n", "", ":NvimTreeResize +10 <CR>")
--normal_key("n", "", ":NvimTreeResize -10 <CR>")

--use_key_space("n", "v", ":NvimTreeFocus <CR>") -- Mueve el cursor al explorador de archivos

-- buffers
normal_key("n", "S-l", cmd.BufferLineCycleNext) -- Ir al siguiente buffer
normal_key("n", "S-k", cmd.BufferLineCyclePrev) -- Ir al buffer anterior
normal_key("n", "C-c", cmd.bd)                  -- Cerrar el buffer (Cerrar el fichero)

-- Mover la linea
normal_key("n", "S-C-Up", function()
  cmd.m("-2")
end)

normal_key("n", "S-C-Down", function()
  cmd.m("+1")
end)

-- Crear nuevo archivo
normal_key("n", "C-n", cmd.new)

-- Mover el cursor de una ventana a otra
normal_key("n", "A-Down", ":wincmd j<CR>")
normal_key("n", "A-Up", ":wincmd k<CR>")
normal_key("n", "A-Left", ":wincmd h<CR>")
normal_key("n", "A-Right", ":wincmd l<CR>")

-- Copiar texto al portapapeles (en Linux se necesita xclip)
normal_key("n", "y", '"+y')
normal_key("n", "p", '"+p')

-- terminal
--normal_key("n", "C-j", ":ToggleTerm<CR>")
--normal_key("t", "C-j", ":wincdmd ToggleTerm<CR>")

-- Renombrar variables
normal_key("n", "C-p", buf.rename)

-- Formatear texto al guardar
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
  group = "__formatter__",
  --command = ":lua vim.lsp.buf.format()",
  command = ":FormatWrite<CR>",
})

-- Telescope
local telescope_preview = {
  find_files = false,
  buffers = false,
  lsp_references = false,
  git_files = false
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
