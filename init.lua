local plugins = {
	"plugins/lazy",
	"plugins/init",
	"keymap",
	"editor_config",
	"autocmd",
}

for _, plugin in ipairs(plugins) do
	require(plugin)
end
