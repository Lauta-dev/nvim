return {
	config = function(bufnr, on_dir)
		local root_markers = {
			"package-lock.json",
			"yarn.lock",
			"pnpm-lock.yaml",
			"bun.lockb",
			"bun.lock",
			"package.json",
		}
		root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers } or root_markers
		local project_root = vim.fs.root(bufnr, root_markers)
		local temp_file_name = "package-lock.json"
		local cache_dir = os.getenv("HOME") .. "/.cache"

		if not project_root then
			-- Crear un package-lock.json básico
			local package_look_json_path = cache_dir .. "/" .. temp_file_name
			if vim.fn.filereadable(package_look_json_path) == 0 then
				local package_look_json_content = vim.json.encode({})

				local file = io.open(package_look_json_path, "w")
				if file then
					file:write(package_look_json_content)
					file:close()
					vim.notify("Created temporary " .. temp_file_name .. " for LSP")
				end
			end

			project_root = current_dir
		end

		on_dir(project_root)
	end,
}
