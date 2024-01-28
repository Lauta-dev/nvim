local lspconfig = require("lspconfig")

lspconfig.tailwindcss.setup({
	filetypes = {
		"astro",
		"javascriptreact",
		"typescriptreact",
	},
})
lspconfig.csharp_ls.setup({})
