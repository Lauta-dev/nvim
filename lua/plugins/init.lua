local file_type = require("plugins/file_type")
local lualine_opts = require("plugins/configs/lualine")

require("lazy").setup({
	-- Dashboard
	{
		"goolord/alpha-nvim",
		config = function()
			local dashboard = require("alpha.themes.dashboard")
			local config = require("plugins.configs.alpha").alpha_config(dashboard)
			require("alpha").setup(config)
		end,
	},

	-- Resalta los comantarios que tendra TODO:
	{
		"folke/todo-comments.nvim",
		ft = file_type,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},

	-- Iconos
	{ "nvim-tree/nvim-web-devicons" },

	-- Cerrar paréntencis
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		ft = file_type,
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	-- Barra de estado
	{
		"nvim-lualine/lualine.nvim",
		ft = file_type,
		config = function()
			require("lualine").setup(lualine_opts)
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
		ft = file_type,
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("nvim-navbuddy").setup()
		end,
		opts = require("plugins.configs.navbody"),
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
	},

	-- Terminal integrada
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
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
		ft = "http",
		dependencies = { "nvim-lua/plenary.nvim" },
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
	{ "mfussenegger/nvim-lint", ft = file_type },

	-- Formateador de texto
	{
		"mhartington/formatter.nvim",
		ft = file_type,
		config = function()
			local opts = require("plugins.configs.formatter-nvim")
			require("formatter").setup(opts)
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
	{ "folke/tokyonight.nvim" },

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

	{ "hrsh7th/cmp-nvim-lsp", ft = file_type },
	{ "hrsh7th/cmp-buffer", ft = file_type },
	{ "hrsh7th/cmp-path", ft = file_type },
	{ "hrsh7th/cmp-cmdline", ft = file_type },
	{ "hrsh7th/nvim-cmp", ft = file_type },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "SergioRibera/cmp-dotenv" },

	-- snippets
	{ "saadparwaiz1/cmp_luasnip", ft = file_type },
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
