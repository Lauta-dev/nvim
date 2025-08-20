local set = vim.keymap.set
local buf = vim.lsp.buf
local cmd = vim.cmd

NVIM_STATES = {
  normal = "n",
  terminal = "t",
}

-- @param `state` Estado del que esta el editor.
-- @param `key` Combinación de teclas que se pulsaran.
-- @param `action` La acción a realizar.
local function normal_key(state, key, action)
  set(state, "<" .. key .. ">", action, { silent = true, noremap = true })
end

-- @param `state` Estado del que esta el editor.
-- @param `key` Combinación de teclas que se pulsaran.
-- @param `action` La acción a realizar.
local function space(state, key, action)
  set(state, "<leader>" .. key, action, { silent = true, noremap = true })
end

local function buffer_exists_by_name(name)
  for _, buf in ipairs(vim.fn.getbufinfo()) do
    if buf.name == name then
      return true
    end
  end
  return false
end

local function fn()
  if buffer_exists_by_name("term") == false then
    return ":vsplit | horizontal resize 50 | terminal<CR><C-\\><C-n> :file term<CR>"
  end

  return "print('hi')"
end

local space_keys = {
  {
    desc = "Go to definition of method or function",
    state = NVIM_STATES.normal,
    key = "gd",
    action = buf.definition,
  },
  {
    desc = "",
    state = NVIM_STATES.normal,
    key = "gh",
    action = buf.hover,
  },
  {
    state = NVIM_STATES.normal,
    key = "sh",
    action = buf.signature_help,
  },
  {
    state = NVIM_STATES.normal,
    key = "e",
    action = ":NvimTreeFocus<CR>",
  },
  {
    state = NVIM_STATES.normal,
    key = "ff",
    action = ":Telescope find_files<CR>",
  },
  {
    state = NVIM_STATES.normal,
    key = "fg",
    action = ":Telescope git_files<CR>",
  },
  {
    state = NVIM_STATES.normal,
    key = "fb",
    action = ":Telescope buffers<CR>",
  },
  {
    state = NVIM_STATES.normal,
    key = "fr",
    action = ":Telescope lsp_references<CR>",
  },
  {
    state = NVIM_STATES.normal,
    key = "ft",
    action = cmd.TodoTelescope,
  },
  {
    state = NVIM_STATES.normal,
    key = "s",
    action = [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  },
}

-- Atajos usando Control
local normal_keys = {
  {
    desc = "View diagnostic",
    state = NVIM_STATES.normal,
    key = "C-l",
    action = vim.diagnostic.open_float,
  },

  {
    desc = "Open file explorer",
    state = NVIM_STATES.normal,
    key = "C-b",
    action = ":NvimTreeToggle<CR>",
  },
  {
    desc = "Save file",
    state = NVIM_STATES.normal,
    key = "C-s",
    action = ":w!<CR>",
  },
  {
    desc = "Close buffer",
    state = NVIM_STATES.normal,
    key = "C-c",
    action = cmd.bd,
  },

  {
    desc = "Move line - up",
    state = NVIM_STATES.normal,
    key = "S-C-Up",
    action = function()
      cmd.m("-2")
    end,
  },

  {
    desc = "Create new file",
    state = NVIM_STATES.normal,
    key = "C-n",
    action = cmd.new,
  },

  {
    desc = "Copy line to clipboard",
    state = NVIM_STATES.normal,
    key = "y",
    action = '"+y',
  },
  {
    desc = "Paste from clipboard",
    state = NVIM_STATES.normal,
    key = "p",
    action = '"+p',
  },

  {
    desc = "rename variables",
    state = NVIM_STATES.normal,
    key = "C-p",
    action = buf.rename,
  },

  {
    desc = "close/open terminal",
    state = NVIM_STATES.normal,
    key = "C-j",
    action = fn(),
  },
}

for _, obj in ipairs(space_keys) do
  space(obj.state, obj.key, obj.action)
end

for _, obj in ipairs(normal_keys) do
  normal_key(obj.state, obj.key, obj.action)
end



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
