local external_plugins = {
	"plugins/lsp",
}

local plugins = {
	{
		"echasnovski/mini.comment",
		version = "*",
		lazy = true,
		opts = require("plugins.configs.mini-commnet"),
	},

	{
		"folke/snacks.nvim",
		lazy = true,
		cmd = { "Snacks", "SnacksPicker" },

		---@type snacks.Config
		opts = {
			bigfile = { enabled = false },
			dashboard = { enabled = false },
			explorer = { enabled = true, replace_netrw = true },

			indent = {
				enabled = true,
				animate = {
					--enabled = vim.fn.has("nvim-0.10") == 1,
					style = "out",
					easing = "linear",
					duration = {
						step = 0, -- ms per step
						total = 0, -- maximum duration
					},
				},
			},
			input = {
				enabled = true,
			},
			picker = {
				enabled = true,
			},
			notifier = { enabled = true },
			quickfile = { enabled = false },
			scope = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
		},
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		lazy = true,
		cmd = "ToggleTerm",
		enabled = false,
	},

	{
		"olimorris/persisted.nvim",
		cmd = {
			"SessionSave",
			"SessionSelect",
			"SessionStart",
		},
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy", -- o la versión estable

		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("fidget").setup({})
		end,
	},

	{
		"b0o/schemastore.nvim",
		lazy = true,
		ft = { "json", "yaml" },
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "SnacksPicker" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},

	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "biome" },
					typescript = { "biome" },
					javascriptreact = { "biome" },
					typescriptreact = { "biome" },
					json = { "biome" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
		end,
		ft = { "lua", "javascript", "javascriptreact", "typescriptreact", "typescript", "json" },
	},

	{
		"nvim-tree/nvim-web-devicons",
		cmd = { "Snacks", "SnacksPicker" },
		lazy = true,
	},
	{
		"windwp/nvim-autopairs",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	{
		"echasnovski/mini.statusline",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		lazy = true,
		opts = require("plugins.configs.mini-statusline"),
	},
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	--event = { "BufReadPre", "BufNewFile" },
	--    opts = {}
	-- },

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local config = require("plugins.configs.nvim-treesitter")
			require("nvim-treesitter.configs").setup(config)
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		config = true,
		enabled = false,
		opts = require("plugins.configs.nvim-tree"),
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		cmd = "Telescope",
		lazy = true,
		enabled = false,

		config = function()
			require("telescope").load_extension("persisted")
			require("telescope").load_extension("fzf")
		end,

		dependencies = {
			"nvim-lua/plenary.nvim",
			"tsakirist/telescope-lazy.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		enabled = false,
		config = function()
			local hooks = require("ibl.hooks")
			local config = require("plugins.configs.indent-blankline")
			config.load_rainbow(hooks)
			require("ibl").setup()
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup(require("plugins.configs.gitsigns-conf"))
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

	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				cs = { "ast-grep" },
				html = { "htmlhint" },
				css = { "stylelint" },
				javascript = { "biome" },
				typescript = { "biome" },
				javascriptreact = { "biome" },
				typescriptreact = { "biome" },
				json = { "biome" },
			}
		end,
		ft = { "cs", "html", "css", "javascriptreact", "javascript", "typescriptreact", "typescript" },
	},

	{
		"nvim-lua/plenary.nvim",
		cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" },
		config = function()
			require("plenary.async")
		end,
	},

	{
		"saghen/blink.cmp",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = require("plugins.configs.blick"),
		opts_extend = { "sources.default" },
	},
}

for _, plugin_module in ipairs(external_plugins) do
	local success, plugin_config = pcall(require, plugin_module)
	if success then
		vim.list_extend(plugins, plugin_config)
	else
		vim.notify("Failed to load plugin: " .. plugin_module, vim.log.levels.WARN)
	end
end

require("lazy").setup(plugins)
