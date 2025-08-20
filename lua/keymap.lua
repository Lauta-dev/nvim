local set = vim.keymap.set
local buf = vim.lsp.buf
local cmd = vim.cmd

-- @param `key` Combinación de teclas que se pulsaran.
-- @param `action` La acción a realizar.
local function normalKey(key, action)
  set("n", "<" .. key .. ">", action, { silent = true, noremap = true })
end

-- @param `key` Combinación de teclas que se pulsaran.
-- @param `action` La acción a realizar.
local function spaceKey(key, action)
  set("n", "<leader>" .. key, action, { silent = true, noremap = true })
end


-- Atajos usando tecla espaciadora
local space_keys = {

  -- Ir a la definición
  { key = "gd", action = buf.definition },

  -- Hacer un hover
  { key = "gh", action = buf.hover },

  -- Mostrar ayuda
  { key = "sh", action = buf.signature_help },

  -- Mover el cursor a file explorer
  { key = "e",  action = ":NvimTreeFocus<CR>" },

  -- Abri telescope para buscar archivos
  { key = "ff", action = ":Telescope find_files<CR>" },

  -- Abrir telescope para buscar buffers
  { key = "fb", action = ":Telescope buffers<CR>" },

  -- Abrir telescope para buscar referencias
  { key = "fr", action = ":Telescope lsp_references<CR>" },

  -- Abri telescope para buscar TODO
  { key = "ft", action = cmd.TodoTelescope, },
  { key = "s",  action = [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]] },
}

-- Atajos usando Control
local normal_keys = {

  -- Devuelve lineas eliminadas (Es lo contrario a "u")
  { key = "C-r",    action = "<C-r>" },

  -- Elimina lineas puestas (Es la accion de "u")
  { key = "C-u",    action = "u" },

  -- Ver diagnostico
  { key = "C-l",    action = vim.diagnostic.open_float },

  -- Abrir file explorer
  { key = "C-b",    action = ":NvimTreeToggle<CR>" },

  -- Guardar cambios
  { key = "C-s",    action = ":w!<CR>" },

  -- Cerrar buffer
  { key = "C-c",    action = cmd.bd },

  -- Mueve la linea a arriba
  { key = "A-Up",   action = function() cmd.m("-2") end },

  -- Mueve la linea a arriba
  { key = "A-Down", action = function() cmd.m("+1") end },

  -- Crear nuevo buffer
  { key = "C-n",    action = cmd.new },

  -- Copiar al portapapeles
  { key = "y",      action = '"+y' },

  -- Pegar desde el portapapeles
  { key = "p",      action = '"+p' },

  -- Renombrar variables/Función
  { key = "C-p",    action = buf.rename },

  -- Abrir/Cerra terminal
  --{ key = "C-j", action = openTerminal(), },
}

for _, obj in ipairs(space_keys) do
  spaceKey(obj.key, obj.action)
end

for _, obj in ipairs(normal_keys) do
  normalKey(obj.key, obj.action)
end

-- Dehabilitar tecla "u" que esta por defecto

set("n", "u", "<Nop>", { noremap = true, silent = true })

----------------------------------------

-- Insert mode Right fluido
vim.keymap.set('i', '<Right>', function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0)) -- fila, columna (0-indexed)
  local line = vim.api.nvim_get_current_line()
  local line_len = #line

  if col >= line_len and row < vim.fn.line('$') then
    -- saltar a la siguiente línea al inicio
    vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
  else
    -- moverse normalmente a la derecha
    feedkey = vim.api.nvim_replace_termcodes('<Right>', true, false, true)
    vim.api.nvim_feedkeys(feedkey, 'n', true)
  end
end, { noremap = true, silent = true })

-- Insert mode Left fluido
vim.keymap.set('i', '<Left>', function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  if col == 0 and row > 1 then
    -- saltar a la línea anterior al final
    local prev_line_len = #vim.api.nvim_buf_get_lines(0, row - 2, row - 1, false)[1]
    vim.api.nvim_win_set_cursor(0, { row - 1, prev_line_len })
  else
    feedkey = vim.api.nvim_replace_termcodes('<Left>', true, false, true)
    vim.api.nvim_feedkeys(feedkey, 'n', true)
  end
end, { noremap = true, silent = true })


-- Normal mode Right
vim.keymap.set('n', '<Right>', function()
  local col = vim.fn.col('.')
  local line_len = math.max(vim.fn.col('$') - 1, 1) -- asegura al menos 1
  local current_line = vim.fn.line('.')
  local max_line = vim.fn.line('$')

  if col >= line_len and current_line < max_line then
    vim.cmd('normal! j0') -- bajar línea e ir al inicio
  else
    vim.cmd('normal! l')
  end
end, { noremap = true, silent = true })

-- Normal mode Left
vim.keymap.set('n', '<Left>', function()
  local col = vim.fn.col('.')
  local current_line = vim.fn.line('.')

  if col == 1 and current_line > 1 then
    vim.cmd('normal! k$') -- subir línea e ir al final
  else
    vim.cmd('normal! h')
  end
end, { noremap = true, silent = true })
