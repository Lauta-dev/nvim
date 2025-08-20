return {
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
}
