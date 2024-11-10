return {
  {
    "hrsh7th/nvim-cmp",
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

  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets/" })
    end,
    dependencies = { "rafamadriz/friendly-snippets" },
  },
}
