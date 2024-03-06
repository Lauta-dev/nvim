local file_type = require("plugins/file_type")

require("lazy").setup({
	{
		"rcarriga/nvim-notify",
		config = function() end,
	},

	-- Resalta los comentarios que tendra TODO:
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
		cmd = { "TodoTelescope" },
	},

	-- Iconos
	{ "nvim-tree/nvim-web-devicons" },

	-- Cerrar paréntencis
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	-- Barra de estado
	{
		"nvim-lualine/lualine.nvim",
		ft = file_type,
		config = function()
			local config = require("plugins/configs/lualine")
			require("lualine").setup(config)
		end,
	},

	-- Resaltador de sintaxis
	{
		"nvim-treesitter/nvim-treesitter",
		ft = file_type,
		config = function()
			require("nvim-treesitter.configs").setup(require("plugins.configs.nvim-treesitter"))
		end,
	},

	-- Agreag popop para ver diferentes partes del código
	{
		"SmiteshP/nvim-navbuddy",
		cmd = "Navbody",

		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},

		config = function()
			local config = require("plugins.configs.navbody")
			require("nvim-navbuddy").setup(config)
		end,
	},

	-- Administrador de archivos
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup()
		end,
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

		opts = {
      defaults = {
            layout_config = {
      vertical = { width = 0.5 },
    },
      },
			pickers = {
				find_files = {
				},
			},
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

	-- Ayuda para hacer peticiones desde archivos .http
	{
		"rest-nvim/rest.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "http",
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

		config = function()
			require("mason").setup()
		end,
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
		ft = file_type,
		config = function()
			require("bufferline").setup({})
		end,
		dependencies = "nvim-tree/nvim-web-devicons",
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
	{ "folke/tokyonight.nvim", priority = 1000 },

	----------------------------------

	-- Lsp
	{
		"williamboman/mason-lspconfig.nvim",
		ft = file_type,
		config = function()
			require("mason-lspconfig").setup()
		end,
	},

	{
		"neovim/nvim-lspconfig",
		ft = file_type,

		config = function()
			local lsp = require("lspconfig")
			lsp.tailwindcss.setup({
				filetypes = {
					"astro",
					"javascriptreact",
					"typescriptreact",
				},
			})

			lsp.bashls.setup({})
			lsp.cssls.setup({})

			lsp.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			lsp.angularls.setup({})
			lsp.csharp_ls.setup({})
			lsp.tsserver.setup({})
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
