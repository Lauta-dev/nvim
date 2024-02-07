require("plugins/init")
require("opciones")

require("config/diagnostic")
require("config/diagnostic-show-border")

local function loadPlugins()
	local config_folder = "plugins/configuracion/"
	local home_dir = os.getenv("HOME") -- Obtener el path del directorio HOME
	local config_path = home_dir .. "/.config/nvim/lua/" .. config_folder -- Path de la configuracion de los plugins
	local p_file = io.popen('ls  "' .. config_path .. '"') -- Se crea un array con todos los archivos

	for dir in p_file:lines() do
		local module_name = dir:gsub(".lua", "") -- Se quita ".lua" de todos los archivos
		local success, module = pcall(require, config_folder .. module_name)

		if not success then
			require("notify")("Error loading module '" .. module_name .. "': " .. module)
		end
	end

	p_file:close()
end

loadPlugins()

require("teclas/teclas")
