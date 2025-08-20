local n = {
  "plugins/lsp",
}

local plugins = {

  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true,
    lazy = true,
    cmd = "ToggleTerm"
  },

  {
    "olimorris/persisted.nvim",
    cmd = {
      "SessionSave",
      "SessionSelect",
      "SessionStart",
    }
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy", -- o la versión estable

    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("fidget").setup {}
    end
  },

  {
    "b0o/schemastore.nvim",
    lazy = true,
    ft = { "json", "yaml" },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    cmd = { "TodoTelescope" },
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
    cmd = {
      "NvimTreeToggle",
    },
    lazy = true
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local config = require("plugins.configs.lualine-conf")
      require("lualine").setup(config)
    end,
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
    "nvim-tree/nvim-tree.lua",
    config = true,
    opts = require("plugins.configs.nvim-tree")
  },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    cmd = "Telescope",
    lazy = true,

    config = function()
      require("telescope").load_extension("persisted")
      require("telescope").load_extension("fzf")
    end,

    dependencies = {
      "nvim-lua/plenary.nvim",
      "tsakirist/telescope-lazy.nvim",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local hooks = require("ibl.hooks")
      local config = require("plugins.configs.indent-blankline")
      config.load_rainbow(hooks)
      require("ibl").setup({ scope = { highlight = config.highlight } })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    cond = function()
      return vim.fn.isdirectory(".git") == 1
    end,

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
    'saghen/blink.cmp',
    event = "InsertEnter",
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = require("plugins.configs.blick"),
    opts_extend = { "sources.default" }
  }
}

for _, v in ipairs(n) do
  for _, d in ipairs(require(v)) do
    table.insert(plugins, d)
  end
end

require("lazy").setup(plugins)
