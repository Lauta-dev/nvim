return {
	keymap = {
		preset = "default",

		["<Up>"] = false,
		["<Down>"] = false,
		["<CR>"] = { "select_and_accept", "fallback" }, -- Enter
		["<A-Up>"] = { "select_prev", "fallback" }, -- Alt+Up
		["<A-Down>"] = { "select_next", "fallback" }, -- Alt+Down
	},

	-- Configuración de fuentes y sus proveedores
	sources = {
		-- Definición de las fuentes activas y su orden de prioridad base
		default = { "lsp", "path", "snippets", "buffer" },

		providers = {
			-- Configuración del servidor de lenguaje
			lsp = {
				name = "LSP",
				module = "blink.cmp.sources.lsp",
				-- Prioridad base alta para el LSP
				score_offset = 100,
				-- Transformación de ítems para manejo de JSX y prioridades de Kind
				transform_items = function(ctx, items)
					local filetype = vim.bo.filetype
					for _, item in ipairs(items) do
						-- Penalización global de snippets dentro de la fuente LSP
						-- (si el LSP también provee snippets)
						if item.kind == vim.lsp.protocol.CompletionItemKind.Snippet then
							item.score_offset = item.score_offset - 100
						end

						-- Lógica específica para React/Next.js en archivos TSX/JSX
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

			-- Configuración avanzada de fragmentos de código
			snippets = {
				name = "Snippets",
				module = "blink.cmp.sources.snippets",
				-- Penalización base para snippets para que no dominen al LSP
				score_offset = -50,
				-- Filtrado contextual basado en el carácter disparador
				should_show_items = function(ctx)
					-- Obtenemos el tipo de disparo inicial
					local trigger_kind = ctx.trigger.initial_kind
					-- Si el disparo fue por un carácter (.) o si ya hay un snippet, ocultamos
					if trigger_kind == "trigger_character" then
						return false
					end
					-- Evitamos ruido adicional si ya estamos dentro de un snippet
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

	-- Configuración del motor de búsqueda y ordenación
	fuzzy = {
		-- Reordenación de los criterios de sort para que score (y offsets)
		-- y sort_text (LSP) tengan precedencia sobre la coincidencia exacta
		sorts = {
			-- 1. Puntuación calculada (incluye offsets de proveedor y transformaciones)
			"score",
			-- 2. Prioridad lógica del servidor de lenguaje (vtsls)
			"sort_text",
			-- 3. Coincidencia textual exacta (movida abajo para evitar el problema de "a.")
			"exact",
			-- 4. Longitud de la etiqueta y orden alfabético
			"label",
		},
	},

	-- Personalización de la interfaz de usuario
	completion = {
		accept = { auto_brackets = { enabled = true } },
		list = {
			selection = { preselect = true, auto_insert = false },
		},
		menu = {
			-- Configuración del renderizado de la lista
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "source_name" },
				},
				components = {
					-- Diferenciación visual de las fuentes
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
			auto_show = true, -- ESTO es lo que te falta
			auto_show_delay_ms = 200, -- Un pequeño delay para que no parpadee al moverte rápido
			window = {
				border = "single",
				-- Esto asegura que se pegue al menú de completado
				direction_priority = {
					menu_north = { "e", "w" },
					menu_south = { "e", "w" },
				},
			},
		},
		-- Control de la visualización automática del menú
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
