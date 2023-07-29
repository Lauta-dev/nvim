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
  'typescript',
  'javascript',
  'bash',
  'javascriptreact',
  'typescriptreact',
  'markdown',
  'lua',
  'html',
  'css'
}


require("lazy").setup({
	{ "nvim-tree/nvim-tree.lua" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "m4xshen/autoclose.nvim" },
	-- { "romgrk/barbar.nvim" },
	{ "nvim-lualine/lualine.nvim" },
	{ "nvim-treesitter/nvim-treesitter" },
  
	{ 'nvim-telescope/telescope.nvim',
	tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { "akinsho/toggleterm.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "SmiteshP/nvim-navic", dependencies = {"neovim/nvim-lspconfig"} },
  { "olimorris/onedarkpro.nvim", priority = 1000 },
  { "goolord/alpha-nvim" },
  { 'kevinhwang91/nvim-bqf' },
  { 'xiyaowong/nvim-cursorword' },
  { "folke/which-key.nvim" },
  { "williamboman/mason.nvim" },
  { "maxmellon/vim-jsx-pretty", ft = 'javascriptreact' },
  {
    "filipdutescu/renamer.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('renamer').setup()
    end
  },

  {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  },

  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
    	require("bufferline").setup{}
    end
  },


  -- Temas
  { "tiagovla/tokyodark.nvim" },
  { "EdenEast/nightfox.nvim" },
  
  -- Lsp
  { "neovim/nvim-lspconfig", ft = fileType },
  { 'hrsh7th/cmp-nvim-lsp', ft = fileType },
  { 'hrsh7th/cmp-buffer', ft = fileType },
  { 'hrsh7th/cmp-path', ft = fileType },
  { 'hrsh7th/cmp-cmdline', ft = fileType },
  { 'hrsh7th/nvim-cmp', ft = fileType },
  { 'saadparwaiz1/cmp_luasnip', ft = fileType },
  
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  }

  --------------------
})

