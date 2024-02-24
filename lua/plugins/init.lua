require("plugins/lazy")
require("plugins/file_type")

require("lazy").setup({
	-- Dashboard
	{ "goolord/alpha-nvim" },

	{ "nvim-tree/nvim-web-devicons" },
	{ "windwp/nvim-autopairs", event = "InsertEnter", ft = file_type },
	{ "nvim-lualine/lualine.nvim" },
	{ "nvim-treesitter/nvim-treesitter", ft = file_type },

	-- Agreag popop para ver diferentes partes del código
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
		opts = { lsp = { auto_attach = true } },
	},

	-- Agrega una linea para ver cuantas veces se usa la funcion
	{
		"Wansmer/symbol-usage.nvim",
		event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
		config = function()
			require("symbol-usage").setup()
		end,
	},

	-- Administrador de archivos
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup()
		end,
	},

	-- Usar algunas funciones de Obsidian en Neovim
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/.obsidian/",
				},
			},
		},
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
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		ft = file_type,
	},
	{
		"rest-nvim/rest.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("rest-nvim").setup({
				--- Get the same options from Packer setup
			})
		end,
	},
	{ "lewis6991/gitsigns.nvim", ft = file_type },
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

	{ "mfussenegger/nvim-lint", ft = file_type },

	{
		"filipdutescu/renamer.nvim",
		ft = file_type,
		branch = "master",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("renamer").setup()
		end,
	},

	{
		"numToStr/Comment.nvim",
		ft = file_type,
		config = function()
			require("Comment").setup()
		end,
	},
	{ "mhartington/formatter.nvim", ft = file_type },

	{
		"akinsho/bufferline.nvim",
		version = "*",
		ft = file_type,
		config = function()
			require("bufferline").setup({})
		end,
		dependencies = "nvim-tree/nvim-web-devicons",
	},

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
	{ "neovim/nvim-lspconfig", ft = file_type },
	{ "hrsh7th/cmp-nvim-lsp", ft = file_type },
	{ "hrsh7th/cmp-buffer", ft = file_type },
	{ "hrsh7th/cmp-path", ft = file_type },
	{ "hrsh7th/cmp-cmdline", ft = file_type },
	{ "hrsh7th/nvim-cmp", ft = file_type },

	{ "williamboman/mason-lspconfig.nvim", ft = file_type },

	-- snippets
	{ "saadparwaiz1/cmp_luasnip", ft = file_type },
	{
		"L3MON4D3/LuaSnip",
		ft = file_type,
		dependencies = { "rafamadriz/friendly-snippets" },
	},
})
