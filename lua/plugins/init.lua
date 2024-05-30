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
				cs = { "ast-grep" },
				html = { "htmlhint" },
				css = { "stylelint" },
				javascript = { "oxlint" },
				typescript = { "oxlint" },
				javascriptreact = { "oxlint" },
				typescriptreact = { "oxlint" },
			}

			require("lint").linters.oxlint = {
				name = "oxlint",
				cmd = "/home/lauta/.local/share/PersonalVim/mason/bin/oxlint",
				stdin = false,
				args = { "--format", "unix" },
				stream = "stdout",
				ignore_exitcode = true,
				parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
					source = "oxlint",
					severity = vim.diagnostic.severity.WARN,
				}),
			}
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
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load()
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

			lsp.tsserver.setup({}) -- JS/TS/JSX/TSX

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
			"saadparwaiz1/cmp_luasnip",
		},

		config = function()
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp_config = require("plugins.configs.cmp_config")
			cmp_config(cmp, cmp_autopairs)
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
