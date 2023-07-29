function map(estado, tecla, accion) vim.keymap.set(estado, "<" .. tecla .. ">", accion) end
function espacio(estado, tecla, accion) vim.keymap.set(estado, "<leader>" .. tecla, accion) end

vim.g.mapleader = " "

map("n", "C-s", ":w<CR>")
map("n", "C-b", ":NvimTreeToggle<CR>")

-- bufferline
map("n", "S-l", ":BufferNext<CR>")
map("n", "S-k", ":BufferPrevious<CR>")
map("n", "C-w", ":BufferClose<CR>")

-- copiar texto
map("n", "y", '"+y')
map("n", "p", '"+p')

-- terminal
map("n", "C-j", ":ToggleTerm<CR>")
map("t", "C-j", "exit<CR>")

map("n", "C-p", 'lua require("renamer").rename()')

-- atajos con espacios
espacio("n", "f", ":NvimTreeFocus<CR>")


vim.api.nvim_set_keymap('i', '<F2>', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })


local api = require('Comment.api')
vim.keymap.set(
  'n', 'gc', api.call('toggle.linewise', 'g@'),
  { expr = true }
)
vim.keymap.set(
  'n', '<C-.>', api.call('toggle.linewise.current', 'g@$'),
  { expr = true }
)
