return {
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },

    config = function()
      local lsp = require("lspconfig")
      --local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local homepath = os.getenv("HOME")

      local angular_cmd = {
        homepath
        ..
        "/.local/share/lauta_dev_nvim/mason/packages/angular-language-server/node_modules/@angular/language-server/bin/ngserver",
        "--stdio",
        "--tsProbeLocations",
        homepath
        .. "/.local/share/lauta_dev_nvim/mason/packages/angular-language-server/node_modules/typescript/lib",
        "--ngProbeLocations",
        homepath
        .. "/.local/share/lauta_dev_nvim/mason/packages/angular-language-server/node_modules/@angular/language-server/",
      }


      -- GO
      lsp.gopls.setup({ capabilities = capabilities })

      -- HTML
      lsp.html.setup({ capabilities = capabilities })

      -- CSS
      lsp.cssls.setup({ capabilities = capabilities })

      -- Angular
      lsp.angularls.setup({
        capabilities = capabilities,
        cmd = angular_cmd,
        on_new_config = function(new_config)
          new_config.cmd = angular_cmd
        end,
      })

      -- TailwindCSS
      lsp.tailwindcss.setup({
        filetypes = {
          "astro",
          "javascriptreact",
          "typescriptreact",
        },
        capabilities = capabilities,
      })

      -- JS/TS/JSX/TSX
      lsp.ts_ls.setup({ capabilities = capabilities })

      -- Docker
      lsp.docker_compose_language_service.setup({ capabilities = capabilities })
      lsp.dockerls.setup({ capabilities = capabilities })

      -- BASH (Linux)
      lsp.bashls.setup({ capabilities = capabilities })

      -- Lua (Linux)
      lsp.lua_ls.setup({
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          })
        end,
        settings = {
          Lua = {},
        },
      })

      -- Python
      lsp.pyright.setup({ capabilities = capabilities })

      -- C#
      lsp.omnisharp.setup(require("plugins.configs.lsp.csharp_omnisharp"))

      -- PHP
      lsp.intelephense.setup({ capabilities = capabilities })

      -- JSON
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.json",
        callback = function(args)
          lsp.jsonls.setup({
            capabilities = capabilities,
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          })
        end
      })

      -- YAML/YML
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.yml",
        callback = function(args)
          lsp.yamlls.setup({
            capabilities = capabilities,
            settings = {
              yaml = {
                schemas = require("schemastore").yaml.schemas(),
                validate = { enable = true },
              },
            },
          })
        end
      })
    end,
  },
}
