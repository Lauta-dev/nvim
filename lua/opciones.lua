local opt = vim.opt
local bg = vim.cmd.colorscheme
bg("tokyonight-night")

opt.shortmess:append("sI")
opt.number = true -- Numero de filas
opt.tabstop = 2 --
opt.expandtab = true -- Usar espacios en lugar de tabulaciones
opt.shiftwidth = 2 -- Establecer la cantidad de espacios para la sangría automática
opt.mouse = "a" -- Habilitar mouse
opt.ignorecase = true --
opt.smartcase = true --
opt.hlsearch = false --
opt.wrap = true -- El texto dara un salto de linea cuando no quede mas espacio
opt.breakindent = true --
opt.fileencoding = "utf-8" -- Codificacion utf-8
opt.cursorline = true -- El cursor estara resaltado
opt.clipboard = "unnamedplus" -- Habilitar portapapeles
opt.termguicolors = true --
opt.conceallevel = 2

-- -- -- -- --
