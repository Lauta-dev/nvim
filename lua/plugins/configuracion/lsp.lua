local lspconfig = require("lspconfig")

lspconfig.tailwindcss.setup({
	filetypes = {
		"astro",
		"javascriptreact",
		"typescriptreact",
	},
})

lspconfig.csharp_ls.setup({
	-- Ruta relativa del script para ejecutar código en C#
	cmd = { "/home/lauta/.local/share/nvim/mason/bin/csharp-ls" },
})

lspconfig.lua_ls.setup({
  cmd = { "/home/lauta/.local/share/nvim/mason/bin/lua-language-server" },
})


