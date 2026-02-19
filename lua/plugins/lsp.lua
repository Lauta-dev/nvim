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
			local lsp = vim.lsp
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			-- Blink ya suele manejar snippets, pero forzarlo no hace daño
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			local servers = {
				go = "gopls",
				vtsls = "vtsls",
				bash = "bashls",
				lua = "lua_ls",
				html = "html",
				css = "cssls",
				css_module = "cssmodules_ls",
				json = "jsonls",
				yaml = "yamlls",
				astro = "astro",
				python = "pyright", -- Simplificado para que coincida con la key
			}

			local serversWithScheme = {
				json = true,
				yaml = true,
			}

			local function add_schema(lang)
				return {
					[lang] = {
						schemas = require("schemastore")[lang].schemas(),
						validate = { enable = true },
					},
				}
			end

			for lang, server in pairs(servers) do
				local config = {
					capabilities = capabilities,
				}

				-- Inyectar Schemas si es necesario
				if serversWithScheme[lang] then
					config.settings = add_schema(lang)
				end

				-- Configuración específica para VTSLS con BUN
				if server == "vtsls" then
					-- Forzamos a Bun para eliminar el lag de inicio de Node
					config.cmd = { "bun", "x", "vtsls", "--stdio" }
					-- Cargamos tus settings específicos (importante para React/Next.js)
					config.settings = require("plugins.configs.lsp.vtsls").settings
				end

				-- Aplicar la configuración al servidor
				lsp.config(server, config)
				-- Activar el servidor
				lsp.enable(server)
			end
		end,
	},
}
