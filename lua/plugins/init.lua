local n = {
  "plugins/autocomplete",
  "plugins/lsp",
  "plugins/themes",
  "plugins/ia",
  "plugins/SchemaStore",
  "plugins/garbage_day"
}

local plugins = {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    cmd = { "TodoTelescope" },
  },
  {
    'mistweaverco/kulala.nvim',
    opts = {},
    ft = { "http" }
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
    ft = { "lua", "javascript", "javascriptreact", "typescriptreact", "typescript", "json" }
  },

  {
    "j-hui/fidget.nvim",
    tag = "v1.0.0",
    opts = {},
  },

  { "nvim-tree/nvim-web-devicons" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local config = require("plugins.configs.lualine_conf")
      require("lualine").setup(config)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local config = require("plugins.configs.nvim-treesitter")
      require("nvim-treesitter.configs").setup(config)
    end,
  },

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
    config = function()
      local hooks = require("ibl.hooks")
      local config = require("plugins.configs.indent-blankline")
      config.load_rainbow(hooks)
      require("ibl").setup({ scope = { highlight = config.highlight } })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
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
        json = { "biome" }
      }
    end,
    ft = { "cs", "html", "css", "javascriptreact", "javascript", "typescriptreact", "typescript" }
  },

  {
    "nvim-lua/plenary.nvim",
    cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" },
    config = function()
      require("plenary.async")
    end,
  },
}

for _, v in ipairs(n) do
  for _, d in ipairs(require(v)) do
    table.insert(plugins, d)
  end
end

require("lazy").setup(plugins)
