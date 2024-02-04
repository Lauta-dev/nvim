local lspconfig = require("lspconfig")
require("mason-lspconfig").setup()

lspconfig.tailwindcss.setup({
	filetypes = {
		"astro",
		"javascriptreact",
		"typescriptreact",
	},
})
