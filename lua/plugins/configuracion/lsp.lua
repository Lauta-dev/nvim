local lspconfig = require("lspconfig")
require("mason-lspconfig").setup()

lspconfig.tailwindcss.setup({
	filetypes = {
		"astro",
		"javascriptreact",
		"typescriptreact",
	},
})

lspconfig.bashls.setup({})
lspconfig.cssls.setup({})
lspconfig.lua_ls.setup({})
lspconfig.angularls.setup({})
lspconfig.csharp_ls.setup({})
lspconfig.tsserver.setup({})
