function req(req)
	require("plugins/configuracion/" .. req)
end

require("plugins/init")
require("teclas/teclas")
require("opciones")
require("config/diagnostic")

local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = _border,
})

vim.diagnostic.config({
	float = { border = _border },
})

for dir in io.popen([[ ls /home/lauta/.config/nvim/lua/plugins/configuracion/ ]]):lines() do
	local a = dir:gsub(".lua", "")
	req(a)
end
