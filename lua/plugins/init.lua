local file_type = require("plugins/file_type")

require("lazy").setup({
	-- Resalta los comentarios que tendra TODO:
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
		cmd = { "TodoTelescope" },
	},

	{
		"goolord/alpha-nvim",
		config = function()
			local config = require("plugins.configs.alpha")
			local dashboard = require("alpha.themes.dashboard")
			require("alpha").setup(config.alpha_config(dashboard))
		end,
	},

	-- Iconos
	{ "nvim-tree/nvim-web-devicons" },

	-- terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		opts = {
			direction = "horizontal",
		},
	},

	-- Cerrar paréntencis
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- Barra de estado
	{
		"nvim-lualine/lualine.nvim",
		ft = file_type,
		config = function()
			local config = require("plugins.configs.lualine_conf")
			require("lualine").setup(config)
		end,
	},

	-- Resaltador de sintaxis
	{
		"nvim-treesitter/nvim-treesitter",
		ft = file_type,
		config = function()
			local config = require("plugins.configs.nvim-treesitter")
			require("nvim-treesitter.configs").setup(config)
		end,
	},

	-- Administrador de archivos
	{
		"nvim-tree/nvim-tree.lua",
		config = true,
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"tsakirist/telescope-lazy.nvim",
		},

		cmd = {
			"Telescope",
			"Telescope find_files",
			"Telescope buffers",
			"Telescope colorscheme",
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		ft = file_type,
		config = function()
			local hooks = require("ibl.hooks")
			local config = require("plugins.configs.indent-blankline")
			config.load_rainbow(hooks)
			require("ibl").setup({ scope = { highlight = config.highlight } })
		end,
	},

	-- Ayuda para git
	{
		"lewis6991/gitsigns.nvim",
		ft = file_type,
		config = function()
			require("gitsigns").setup(require("plugins.configs.gitsigns-nvim"))
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},

		config = true,
	},

	-- Linter
	{
		"mfussenegger/nvim-lint",
		ft = file_type,
		config = function()
			require("lint").linters_by_ft = {
				typescript = { "biome" },
				javascript = { "biome" },
			}
		end,
		enable = false,
	},

	-- Formateador de texto
	{
		"mhartington/formatter.nvim",
		ft = file_type,
		config = function()
			require("formatter").setup(require("plugins.configs.formatter-nvim"))
		end,
	},

	-- Ver archivos abiertos
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "BufEnter",
		config = true,
	},

	-- Dep de otros plugins
	{
		"nvim-lua/plenary.nvim",
		cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" },
		config = function()
			require("plenary.async")
		end,
	},

	-- Temas
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		enable = false,
	},
	{
		"AstroNvim/astrotheme",
		config = function()
			require("astrotheme").setup({
				palette = "astrodark", -- String of the default palette to use when calling `:colorscheme astrotheme`
			})
		end,
	},

	----------------------------------

	-- Lsp
	{
		"williamboman/mason-lspconfig.nvim",
		ft = file_type,
		config = true,
	},

	{
		"neovim/nvim-lspconfig",
		ft = file_type,

		config = function()
			local lsp = require("lspconfig")
			--Enable (broadcasting) snippet capability for completion
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

			lsp.tsserver.setup({ capabilities = capabilities }) -- JS/TS/JSX/TSX

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
		end,
	},

	-- Autocompletado
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"SergioRibera/cmp-dotenv",
			"saadparwaiz1/cmp_luasnip",
		},

		config = function()
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local kind_icons = require("icon.kind_icon")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				view = {
					--entries = { name: "custom",  }, -- can be "custom", "wildmenu" or "native"
					entries = { name = "custom", selection_order = "near_cursor" },
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "nvim_lsp_signature_help" },
					--{ name = "dotenv" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				formatting = {
					format = function(entry, vim_item)
						vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
						vim_item.menu = ({
							buffer = "",
							nvim_lsp = "",
							luasnip = "",
							nvim_lua = "",
							latex_symbols = "",
						})[entry.source.name]
						return vim_item
					end,
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},

	-- snippets
	{
		"L3MON4D3/LuaSnip",
		ft = file_type,
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets/" })
		end,
		dependencies = { "rafamadriz/friendly-snippets" },
	},
})
