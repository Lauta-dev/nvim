local lspconfig = require("lspconfig")

lspconfig.tailwindcss.setup({
	filetypes = {
		"astro",
		"javascriptreact",
		"typescriptreact",
	},
})
require("lspconfig").csharp_ls.setup({})
