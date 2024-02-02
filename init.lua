local function plugin_configuration(config)
	require("plugins/configuracion/" .. config)
end

require("plugins/init")
require("teclas/teclas")
require("opciones")

require("config/diagnostic")
require("config/diagnostic-show-border")

for dir in io.popen([[ ls /home/lauta/.config/nvim/lua/plugins/configuracion/ ]]):lines() do
	local a = dir:gsub(".lua", "")
	plugin_configuration(a)
end


