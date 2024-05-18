local plugins = {
	"plugins/lazy",
	"plugins/init",
	"editor_config",
	"keymap",
	"autocmd",
}

for _, plugin in ipairs(plugins) do
	require(plugin)
end
