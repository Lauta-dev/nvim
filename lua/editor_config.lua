-- ============================================================
--  Opciones del editor
-- ============================================================

local opt = vim.opt
local g = vim.g

-- ── Colorscheme ─────────────────────────────────────────────
vim.cmd.colorscheme("catppuccin-mocha")

-- ── Leader ──────────────────────────────────────────────────
g.mapleader = " "
g.maplocalleader = " "

-- Deshabilitar netrw (usamos snacks explorer)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- ── UI ───────────────────────────────────────────────────────
opt.number = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.scrolloff = 10
opt.wrap = true
opt.breakindent = true
opt.conceallevel = 3
opt.shortmess:append("sI")

-- ── Búsqueda ────────────────────────────────────────────────
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- ── Indentación ─────────────────────────────────────────────
opt.tabstop = 2 -- espacios que representa un tab visual
opt.shiftwidth = 2 -- espacios usados por << / >>
opt.expandtab = true -- usar espacios en lugar de tabs reales

-- ── Miscelánea ──────────────────────────────────────────────
opt.mouse = "a"
opt.fileencoding = "utf-8"
opt.clipboard = "unnamedplus"

-- ── Historial persistente ───────────────────────────────────
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- ── Clipboard según entorno gráfico ─────────────────────────
local is_wayland = os.getenv("XDG_SESSION_TYPE") == "wayland"

g.clipboard = is_wayland
		and {
			name = "wl-clipboard",
			copy = { ["+"] = "wl-copy", ["*"] = "wl-copy" },
			paste = { ["+"] = "wl-paste --no-newline", ["*"] = "wl-paste --no-newline" },
			cache_enabled = true,
		}
	or {
		name = "xclip",
		copy = { ["+"] = "xclip -selection clipboard", ["*"] = "xclip -selection clipboard" },
		paste = { ["+"] = "xclip -selection clipboard -o", ["*"] = "xclip -selection clipboard -o" },
		cache_enabled = true,
	}

-- ── Diagnósticos ────────────────────────────────────────────
vim.diagnostic.config({
	update_in_insert = true,
	signs = false,
	underline = true,
	virtual_text = { prefix = "●" },
	virtual_lines = false,
	float = {
		focusable = true,
		border = "single",
	},
})
