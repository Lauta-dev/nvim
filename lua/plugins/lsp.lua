return {
	{ "williamboman/mason-lspconfig.nvim", config = true },

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
			--local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

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

			lsp.ts_ls.setup({ capabilities = capabilities }) -- JS/TS/JSX/TSX

			-- Docker
			lsp.docker_compose_language_service.setup({ capabilities = capabilities })
			lsp.dockerls.setup({ capabilities = capabilities })

			-- BASH (Linux)
			lsp.bashls.setup({ capabilities = capabilities })

			-- Lua (Linux)
			lsp.lua_ls.setup({
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Depending on the usage, you might want to add additional paths here.
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							},
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
							-- library = vim.api.nvim_get_runtime_file("", true)
						},
					})
				end,
				settings = {
					Lua = {},
				},
			})

			-- Python
			lsp.pyright.setup({ capabilities = capabilities })

			-- C#
			lsp.omnisharp.setup(require("plugins.configs.lsp.csharp_omnisharp"))

			-- PHP
			lsp.intelephense.setup({ capabilities = capabilities })

			-- JSON
			lsp.jsonls.setup({
				capabilities = capabilities,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			-- yaml
			lsp.yamlls.setup({
				capabilities = capabilities,
				settings = {
					yaml = {
						schemas = require("schemastore").yaml.schemas(),
						validate = { enable = true },
					},
				},
			})
		end,
	},
}
