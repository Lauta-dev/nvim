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

	-- ── Snacks.nvim ───────────────────────────────────────────────────────────────
	{
		"folke/snacks.nvim",
		priority = 900,
		lazy = false,
		-- Only dashboard + notifier + quickfile need to be ready at start.
		-- Everything else (picker, indent, words…) loads on demand.
		opts = {
			-- Big file protection
			bigfile = { enabled = true, size = 1.5 * 1024 * 1024 },

			-- Dashboard
			dashboard = {
				enabled = true,
				preset = {
					header = [[
 ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
 ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = function()
								require("snacks").picker.files()
							end,
						},
						{
							icon = " ",
							key = "g",
							desc = "Live Grep",
							action = function()
								require("snacks").picker.grep()
							end,
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent",
							action = function()
								require("snacks").picker.recent()
							end,
						},
						{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},

			-- Picker (replaces Telescope entirely)
			picker = {
				enabled = true,
				ui_select = true, -- replaces vim.ui.select
				sources = {
					explorer = {
						-- Snacks file-tree explorer
						hidden = true,
						ignore = true,
					},
				},
				win = {
					input = {
						keys = {
							["<Esc>"] = { "close", mode = { "i", "n" } },
						},
					},
				},
			},

			-- Explorer sidebar
			explorer = { enabled = true },

			-- Indent guides (replaces indent-blankline for speed)
			indent = {
				enabled = true,
				animate = { enabled = false },
				scope = { enabled = true },
				chunk = { enabled = false },
			},

			input = { enabled = true },
			notifier = { enabled = true, timeout = 3000, style = "compact" },
			quickfile = { enabled = true }, -- fast open for big files
			scroll = { enabled = false }, -- skip scroll animations for perf
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
		keys = {
			{
				"<leader>bd",
				function()
					require("snacks").bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>gB",
				function()
					require("snacks").gitbrowse()
				end,
				desc = "Git Browse",
			},
			{
				"<leader>nh",
				function()
					require("snacks").notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<leader>un",
				function()
					require("snacks").notifier.hide()
				end,
				desc = "Dismiss Notifications",
			},
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
		lazy = false,
		opts = {
			flavour = "mocha",
			transparent_background = false,
			term_colors = true,
			integrations = {
				blink_cmp = true,
				gitsigns = true,
				indent_blankline = { enabled = true },
				mason = true,
				mini = { enabled = true },
				nvimtree = false, -- using snacks explorer
				telescope = { enabled = false },
				treesitter = true,
				fidget = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
				},
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			style = "night",
	-- 		})
	-- 	end,
	-- },

	{
		"j-hui/fidget.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = { notification = { window = { winblend = 0 } } },
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
					astro = { "prettier" },
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

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local config = require("plugins.configs.nvim-treesitter")
			require("nvim-treesitter.configs").setup(config)
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

require("lazy").setup(plugins, {
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"rplugin",
			},
		},
	},
})
