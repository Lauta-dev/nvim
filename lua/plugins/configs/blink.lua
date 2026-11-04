return {
	keymap = {
		preset = "default",
		["<CR>"] = { "select_and_accept", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },

		["<Esc>"] = {
			function(cmp)
				if cmp.is_visible() then
					cmp.hide()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
				end
			end,
		},
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },

		providers = {
			lsp = {
				name = "LSP",
				module = "blink.cmp.sources.lsp",
				score_offset = 100,
				transform_items = function(ctx, items)
					local filetype = vim.bo.filetype
					for _, item in ipairs(items) do
						if item.kind == vim.lsp.protocol.CompletionItemKind.Snippet then
							item.score_offset = item.score_offset - 100
						end

						if filetype == "typescriptreact" or filetype == "javascriptreact" then
							if item.label == "className" then
								item.score_offset = item.score_offset + 500
							elseif item.label == "class" then
								item.score_offset = item.score_offset - 200
							end
						end
					end
					return items
				end,
			},

			snippets = {
				name = "Snippets",
				module = "blink.cmp.sources.snippets",
				score_offset = -50,
				should_show_items = function(ctx)
					local trigger_kind = ctx.trigger.initial_kind
					if trigger_kind == "trigger_character" then
						return false
					end
					return not require("blink.cmp").snippet_active()
				end,
			},
			path = {
				name = "Path",
				module = "blink.cmp.sources.path",
				score_offset = 25,
			},
		},
	},

	fuzzy = {
		sorts = {
			"score",
			"sort_text",
			"exact",
			"label",
		},
	},

	completion = {
		accept = { auto_brackets = { enabled = true } },
		list = {
			selection = { preselect = true, auto_insert = false },
		},
		menu = {
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "source_name" },
				},
				components = {
					source_name = {
						text = function(ctx)
							local names = { LSP = "", Snippets = "", Path = "", Buffer = "" }
							return names[ctx.source_name] or ctx.source_name
						end,
						highlight = "BlinkCmpSource",
					},
				},
			},
		},
		ghost_text = { enabled = false },
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = {
				border = "single",
				direction_priority = {
					menu_north = { "e", "w" },
					menu_south = { "e", "w" },
				},
			},
		},
		trigger = {
			show_on_trigger_character = true,
		},
	},
	signature = { window = { border = "single" } },
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
	},
}
