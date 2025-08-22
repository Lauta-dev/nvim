return {
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},

	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },

		config = function()
			--local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lsp = vim.lsp
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			local servers = {
				go = "gopls",
				ts_ls = "ts_ls",
				bash = "bashls",
				lua = "lua_ls",
				html = "html",
				css = "cssls",
				css_module = "cssmodules_ls",
				json = "jsonls",
				yaml = "yamlls",
			}

			local serversWithScheme = {
				json = "jsonls",
				yaml = "yamlls",
			}

			--- @param lang string Lenguaje
			local function add_schema(lang)
				return {
					[lang] = {
						schemas = require("schemastore")[lang].schemas(),
						validate = { enable = true },
					},
				}
			end

			for lang, server in pairs(servers) do
				local config = { capabilities = capabilities }

				if serversWithScheme[lang] then
					config.settings = add_schema(lang)
				end

				if lang == "ts_ls" then
					config.root_dir = require("plugins.configs.lsp.ts_ls").config
				end

				lsp.config(server, config)
				lsp.enable(server)
			end
		end,
	},
}
