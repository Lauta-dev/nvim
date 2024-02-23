local opt = vim.opt
local api = vim.api
local bg = vim.cmd.colorscheme
local g = vim.g

function Colore(color)
	color = color or "tokyonight-night"
	bg(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

Colore()

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.mapleader = " " -- Uso de la tecla espacio

opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 10
opt.signcolumn = "yes"

opt.shortmess:append("sI")
opt.number = true -- Numero de filas
opt.tabstop = 2 --
opt.expandtab = true -- Usar espacios en lugar de tabulaciones
opt.shiftwidth = 2 -- Establecer la cantidad de espacios para la sangría automática
opt.mouse = "a" -- Habilitar mouse
opt.ignorecase = true --
opt.smartcase = true --
opt.hlsearch = false --
opt.wrap = false -- El texto dara un salto de linea cuando no quede mas espacio
opt.breakindent = true --
opt.fileencoding = "utf-8" -- Codificacion utf-8
opt.cursorline = true -- El cursor estara resaltado
opt.clipboard = "unnamedplus" -- Habilitar portapapeles
opt.termguicolors = true --
opt.conceallevel = 2
