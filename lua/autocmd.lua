-- ============================================================
--  Autocomandos
-- ============================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ── Resaltar al yank ────────────────────────────────────────
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.highlight.on_yank({ timeout = 150 })
	end,
	desc = "Resaltar región al copiar",
})

-- ── Volver a la última posición del cursor ──────────────────
augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
	group = "RestoreCursor",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local line_count = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	desc = "Restaurar cursor a la última posición",
})

-- ── Formatear con conform al guardar ────────────────────────
-- Descomentar cuando tengas conform configurado:
-- augroup("AutoFormat", { clear = true })
-- autocmd("BufWritePre", {
-- 	group    = "AutoFormat",
-- 	callback = function(args) require("conform").format({ bufnr = args.buf }) end,
-- 	desc     = "Formatear buffer al guardar",
-- })

-- ── Keymaps para terminal ────────────────────────────────────
augroup("TermKeymaps", { clear = true })
autocmd("TermOpen", {
	group = "TermKeymaps",
	pattern = "term://*",
	callback = function()
		vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = 0, desc = "Salir del modo terminal" })
	end,
	desc = "Keymaps dentro del terminal",
})
