require("plugins/lazy")
require("plugins/init")
require("editor_config")
require("keymap")

local function load_plugins()
	local config_folder = "plugins/configs/"
	local home_dir = os.getenv("HOME") -- Obtener el path del directorio HOME
	local config_path = home_dir .. "/.config/nvim/lua/" .. config_folder -- Path de la configuracion de los plugins
	local p_file = io.popen('ls  "' .. config_path .. '"') -- Se crea un array con todos los archivos

	-- Verificar si p_file es nil
	if p_file == nil then
		vim.notify("No se pudo abrir el directorio: " .. config_path)
		return
	end

	for dir in p_file:lines() do
		local module_name = dir:gsub(".lua", "") -- Se quita ".lua" de todos los archivos

		-- Si hay algun error, por ejemplo no encuentra un plugin será capturado
		-- evitando que el script deje de ejecutar si encuentra un error.
		local success, module = pcall(require, config_folder .. module_name)

		if not success then
			-- Se usa una notificación que se ejecuta cada ves para informar el error, no desaparece hasta arreglarlo
			-- O quitar el require() de la configuración
			vim.notify("Error loading module '" .. module_name .. "': " .. module)
		end
	end

	p_file:close()
end

load_plugins()
