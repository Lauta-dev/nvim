local plugins = {
	"plugins/lazy",
	"plugins/init",
	"editor_config",
	"autocmd",
	"keymap",
}

for _, plugin in ipairs(plugins) do
	require(plugin)
end
