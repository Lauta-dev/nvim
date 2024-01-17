require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    typescript = {
      require("formatter.filetypes.typescript").biome
    },
    javascript = {
      require("formatter.filetypes.javascript").biome
    },
    typescriptreact = {
      require("formatter.filetypes.typescriptreact").biome
    },
    javascriptreact = {
      require("formatter.filetypes.javascriptreact").biome
    }
  }
}
