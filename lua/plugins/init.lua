local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local fileType = {
	"typescript",
	"javascript",
	"bash",
	"javascriptreact",
	"typescriptreact",
	"markdown",
	"lua",
	"html",
	"css",
	"astro",
	"python",
	"cs",
}

require("lazy").setup({
	{ "nvim-tree/nvim-web-devicons" },
	{ "windwp/nvim-autopairs", event = "InsertEnter", ft = fileType },
	{ "nvim-lualine/lualine.nvim" },
	{ "nvim-treesitter/nvim-treesitter", ft = fileType },

	-- Administrador de archivos
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},

	-- Plugin para usar Obsidian en Neovim
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		--   "BufReadPre path/to/my-vault/**.md",
		--   "BufNewFile path/to/my-vault/**.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/.obsidian/",
				},
			},

			-- see below for full list of options 👇
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
		ft = fileType,
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({ scope = { highlight = highlight } })

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
	{ "rest-nvim/rest.nvim", ft = "http" },
	{ "lewis6991/gitsigns.nvim", ft = fileType },
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

	{ "mfussenegger/nvim-lint", ft = fileType },

	{
		"filipdutescu/renamer.nvim",
		ft = fileType,
		branch = "master",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("renamer").setup()
		end,
	},

	{
		"numToStr/Comment.nvim",
		ft = fileType,
		config = function()
			require("Comment").setup()
		end,
	},
	{ "mhartington/formatter.nvim", ft = fileType },

	{
		"akinsho/bufferline.nvim",
		version = "*",
		ft = fileType,
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({})
		end,
	},

	{
		"nvim-lua/plenary.nvim",
		cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" },
		config = function()
			require("plenary.async")
		end,
	},

	-- Temas
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	----------------------------------

	-- Lsp
	{ "neovim/nvim-lspconfig", ft = fileType },
	{ "hrsh7th/cmp-nvim-lsp", ft = fileType },
	{ "hrsh7th/cmp-buffer", ft = fileType },
	{ "hrsh7th/cmp-path", ft = fileType },
	{ "hrsh7th/cmp-cmdline", ft = fileType },
	{ "hrsh7th/nvim-cmp", ft = fileType },
	{ "onsails/lspkind.nvim", ft = fileType },

	{ "williamboman/mason-lspconfig.nvim", ft = fileType },

	-- snippets
	{ "saadparwaiz1/cmp_luasnip", ft = fileType },
	{
		"L3MON4D3/LuaSnip",
		ft = fileType,
		dependencies = { "rafamadriz/friendly-snippets" },
	},
})
