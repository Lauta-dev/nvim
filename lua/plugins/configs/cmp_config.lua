local function cmp_init(cmp, cmp_autopairs)
	local kind_icons = require("icon.kind_icon")

	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
	require("lspconfig")["tsserver"].setup({
		capabilities = capabilities,
	})
	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		view = {
			--entries = { name: "custom",  }, -- can be "custom", "wildmenu" or "native"
			entries = { name = "custom", selection_order = "near_cursor" },
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		sources = {
			{ name = "path" },
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "nvim_lsp_signature_help" },
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		formatting = {
			format = function(entry, vim_item)
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
				vim_item.menu = ({
					buffer = "",
					nvim_lsp = "",
					luasnip = "",
					nvim_lua = "",
					latex_symbols = "",
				})[entry.source.name]
				return vim_item
			end,
		},
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

return cmp_init
