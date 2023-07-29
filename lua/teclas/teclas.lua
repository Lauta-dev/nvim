function map(estado, tecla, accion) 
  vim.keymap.set(estado, "<" .. tecla .. ">", accion, { silent = true, noremap = true }) 
end

function espacio(estado, tecla, accion) 
  vim.keymap.set(estado, "<leader>" .. tecla, accion, { silent = true, noremap = true }) 
end

-- key <leader>
vim.g.mapleader = " "

map("n", "C-s", ":w!<CR>")
map("n", "C-x", ":q!<CR>")

-- file explorer
map("n", "C-b", ":NvimTreeToggle<CR>")

-- buffers
map("n", "S-l", ":BufferLineCycleNext<CR>")
map("n", "S-k", ":BufferLineCyclePrev<CR>")
map("n", "C-w", ":BufferLinePickClose<CR>")

-- copy text
map("n", "y", '"+y')
map("n", "p", '"+p')

-- terminal
map("n", "C-j", ":ToggleTerm<CR>")
map("t", "C-j", ":wincdmd ToggleTerm<CR>")

map("n", "C-p", 'lua require("renamer").rename()')

-- atajos con espacios
espacio("n", "e", ":NvimTreeFocus<CR>")

-- Rename text
espacio('n', 'rn', ':lua require("renamer").rename()<cr>')

local api = require('Comment.api')
vim.keymap.set(
  'n', 'gc', api.call('toggle.linewise', 'g@'),
  { expr = true }
)
vim.keymap.set(
  'n', '<C-.>', api.call('toggle.linewise.current', 'g@$'),
  { expr = true }
)


-- Telescope
espacio('n', 'ff', ':Telescope find_files<CR>')
espacio('n', 'fb', ':Telescope buffers<CR>')
espacio('n', 'cs', ':Telescope colorscheme<CR>')


-- package-info
espacio('n', 'pt', require("package-info").toggle)
espacio('n', 'pi', require("package-info").install)
espacio('n', 'pu', require("package-info").update)
espacio('n', 'pd', require("package-info").delete)

-- pt 



-- Show dependency versions
-- vim.keymap.set({ "n" }, "<LEADER>ns", require("package-info").show, { silent = true, noremap = true })

-- Hide dependency versions
-- vim.keymap.set({ "n" }, "<LEADER>nc", require("package-info").hide, { silent = true, noremap = true })

-- Toggle dependency versions
-- vim.keymap.set({ "n" }, "<leader>nt", , { silent = true, noremap = true })

-- Update dependency on the line
-- vim.keymap.set({ "n" }, "<LEADER>nu", require("package-info").update, { silent = true, noremap = true })

-- Delete dependency on the line
-- vim.keymap.set({ "n" }, "<LEADER>nd", require("package-info").delete, { silent = true, noremap = true })

-- Install a new dependency
-- vim.keymap.set({ "n" }, "<LEADER>ni", require("package-info").install, { silent = true, noremap = true })

-- Install a different dependency version
-- vim.keymap.set({ "n" }, "<LEADER>np", require("package-info").change_version, { silent = true, noremap = true })
