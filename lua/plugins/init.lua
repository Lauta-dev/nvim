local n = {
  "plugins/lsp",
  "plugins/themes",
  "plugins/SchemaStore",
}

local plugins = {
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        --opts.ensure_installed = opts.ensure_installed or {}
        --table.insert(opts.ensure_installed, "http")
      end,
    },
    enabled = false,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    cmd = { "TodoTelescope" },
  },

  {
    "mistweaverco/kulala.nvim",
    opts = {},
    ft = { "http" },
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
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'default' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  }
}

for _, v in ipairs(n) do
  for _, d in ipairs(require(v)) do
    table.insert(plugins, d)
  end
end

require("lazy").setup(plugins)
