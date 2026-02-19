return {
	settings = {
		-- Configuraciones específicas de VTSLS
		vtsls = {
			autoUseWorkspaceTsdk = true,
			enableMoveToFileCodeAction = true,
			experimental = {
				completion = {
					enableServerSideFuzzyMatch = true,
					entriesLimit = 50,
				},
			},
			tsserver = {
				globalPlugins = {
					-- Ejemplo para añadir soporte de Vue si fuera necesario
					-- { name = "@vue/typescript-plugin", location = "ruta/al/plugin", languages = {"vue"} }
				},
			},
		},
		-- Configuraciones heredadas de VSCode TypeScript
		typescript = {
			tsserver = {
				maxTsServerMemory = 8192, -- 8GB para proyectos grandes
			},
			inlayHints = {
				parameterNames = { enabled = "literals" },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
			preferences = {
				importModuleSpecifier = "non-relative", -- Prefiere rutas absolutas/alias
			},
		},
		javascript = {
			-- Las mismas opciones de inlayHints suelen replicarse para JS
			inlayHints = {
				parameterNames = { enabled = "literals" },
			},
		},
	},
}
