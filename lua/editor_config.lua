local opt = vim.opt
local g = vim.g

-- Colorscheme
vim.cmd.colorscheme("catppuccin-mocha")

-- Leader
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.mapleader = " "
g.maplocalleader = " "

-- Opciones globales
opt.hlsearch = false
opt.incsearch = true
opt.scrolloff = 10
opt.signcolumn = "yes"
opt.shortmess:append("sI")
opt.number = true
opt.mouse = "a"
opt.ignorecase = true
opt.smartcase = true
opt.wrap = true
opt.breakindent = true
opt.fileencoding = "utf-8"
opt.cursorline = true
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.conceallevel = 3

-- Activa el historial persistente
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"

-- Configuración de diagnostics
vim.diagnostic.config({
  update_in_insert = true,
  signs = false,
  underline = true,
  virtual_text = {
    prefix = "●"
  },
  virtual_lines = false,
  float = {
    focusable = true,
    border = "single",

  },
})

-- Configuración general de tabs en Neovim
vim.opt.tabstop = 2      -- Cuántos espacios representa un tab
vim.opt.shiftwidth = 2   -- Cuántos espacios usa << o >> al indentar
vim.opt.expandtab = true -- Usar espacios en vez de tabs
