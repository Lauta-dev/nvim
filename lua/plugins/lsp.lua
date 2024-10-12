return {
	{
		"williamboman/mason-lspconfig.nvim",
		config = true,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"SmiteshP/nvim-navbuddy",
				dependencies = {
					"SmiteshP/nvim-navic",
					"MunifTanjim/nui.nvim",
				},
				opts = { lsp = { auto_attach = true } },
			},
		},
		config = function()
			local lsp = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- WEB
			lsp.html.setup({ capabilities = capabilities }) -- HTML
			lsp.cssls.setup({ capabilities = capabilities }) -- CSS
			lsp.angularls.setup({ capabilities = capabilities }) -- Angular

			lsp.tailwindcss.setup({ -- TailwindCSS
				filetypes = {
					"astro",
					"javascriptreact",
					"typescriptreact",
				},
				capabilities = capabilities,
			})

			lsp.ts_ls.setup({}) -- JS/TS/JSX/TSX

			-- Docker
			lsp.docker_compose_language_service.setup({ capabilities = capabilities })
			lsp.dockerls.setup({ capabilities = capabilities })

			-- BASH (Linux)
			lsp.bashls.setup({ capabilities = capabilities })

			-- Lua (Linux)
			lsp.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
				capabilities = capabilities,
			})

			-- Python
			lsp.pyright.setup({ capabilities = capabilities })

			-- C#
			lsp.omnisharp.setup(require("plugins.configs.lsp.csharp_omnisharp"))

      -- PHP
      lsp.intelephense.setup{}
		end,
	},
}
