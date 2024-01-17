function req(req)
	require("plugins/configuracion/" .. req)
end

require("plugins/init")
require("teclas/teclas")
require("opciones")

for dir in io.popen([[ ls /home/lauta/.config/nvim/lua/plugins/configuracion/ ]]):lines() do
	local a = dir:gsub(".lua", "")
	req(a)
end
