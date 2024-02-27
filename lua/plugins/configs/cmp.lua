local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local kind_icons = {
	Text = "",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰇽",
	Variable = "󰂡",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰅲",
}

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

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

	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),

	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "dotenv" },
	}, {
		{
			name = "buffer",
			option = {
				path = ".",
				load_shell = true,
				item_kind = cmp.lsp.CompletionItemKind.Variable,
				eval_on_confirm = false,
				show_documentation = false,
				show_content_on_docs = false,
				documentation_kind = "markdown",
				dotenv_environment = ".*",
				file_priority = function(a, b)
					return a:upper() < b:upper()
				end,
			},
		},
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

	cmdline = {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	},
})

cmp.setup({})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

--[[
cmp.setup({
	view = {
	},
	window = {
	},
	mapping = ,
	,
})
cmp.setup({
	,

	cmdline = {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	},
})
--]]

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
