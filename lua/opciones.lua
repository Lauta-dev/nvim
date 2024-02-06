local set = vim.opt
local bg = vim.cmd.colorscheme
bg("catppuccin-mocha")

set.number = true -- Numero de filas
set.tabstop = 2 --
set.expandtab = true -- Usar espacios en lugar de tabulaciones
set.shiftwidth = 2 -- Establecer la cantidad de espacios para la sangría automática
set.mouse = "a" -- Habilitar mouse
set.ignorecase = true --
set.smartcase = true --
set.hlsearch = false --
set.wrap = true -- El texto dara un salto de linea cuando no quede mas espacio
set.breakindent = true --
set.fileencoding = "utf-8" -- Codificacion utf-8
set.cursorline = true -- El cursor estara resaltado
set.clipboard = "unnamedplus" -- Habilitar portapapeles
set.termguicolors = true --
set.conceallevel = 2

-- gray
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
-- blue
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
-- light blue
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
-- pink
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
-- front
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })
