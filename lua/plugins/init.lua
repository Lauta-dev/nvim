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
	-- C#
	-- { "OmniSharp/omnisharp-vim", ft = { "cs" } },

	-- Notificaciones
	{ "echasnovski/mini.nvim", version = false },

	{ "onsails/lspkind.nvim" },

	-- Alpha
	{ "goolord/alpha-nvim" },

	{ "nvim-tree/nvim-tree.lua" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "windwp/nvim-autopairs", event = "InsertEnter", ft = fileType },
	{ "m4xshen/autoclose.nvim", ft = fileType },
	{ "nvim-lualine/lualine.nvim" },
	{ "nvim-treesitter/nvim-treesitter", ft = fileType },
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

	{ "lukas-reineke/indent-blankline.nvim" },
	{ "rest-nvim/rest.nvim", ft = "http" },
	{ "lewis6991/gitsigns.nvim", ft = fileType },
	{ "xiyaowong/nvim-cursorword", ft = fileType },
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
		"maxmellon/vim-jsx-pretty",
		ft = { "javascriptreact", "typescriptreact" },
	},

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
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({})
		end,
	},

	--
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				--null_ls.builtins.formatting.eslint_d,
				null_ls.builtins.diagnostics.eslint_d,
				-- null_ls.builtins.completion.spell,
			})
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
	{ "EdenEast/nightfox.nvim" },
	{ "marko-cerovac/material.nvim" },

	----------------------------------

	-- Lsp
	{ "neovim/nvim-lspconfig", ft = fileType },
	{ "hrsh7th/cmp-nvim-lsp", ft = fileType },
	{ "hrsh7th/cmp-buffer", ft = fileType },
	{ "hrsh7th/cmp-path", ft = fileType },
	{ "hrsh7th/cmp-cmdline", ft = fileType },
	{ "hrsh7th/nvim-cmp", ft = fileType },

	-- snippets
	{ "saadparwaiz1/cmp_luasnip", ft = fileType },
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		ft = fileType,
	},
})
