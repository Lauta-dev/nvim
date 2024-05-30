vim.api.nvim_create_augroup("AutoFormat", {})
local mason_bin_folder = os.getenv("HOME") .. "/.local/share/PersonalVim/mason/bin/"

local current_buffer = vim.api.nvim_eval("expand('%:p')")

local function autocmd(pattern, cmd, args)
	local args_str = table.concat(args, " ")

	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = pattern,
		group = "AutoFormat",
		callback = function()
			vim.cmd("silent !" .. cmd .. " " .. args_str .. " " .. current_buffer)
		end,
	})
end

local list = {
	{
		pattern = "*.lua",
		formatter = "stylua",
		args = {},
	},
	{
		pattern = "*.cs",
		formatter = "dotnet-csharpier",
		args = { "--fast" },
	},
	{
		pattern = { "*.js", "*.ts", "*.json", "*.jsx" },
		formatter = "biome",
		args = { "format", "--write" },
	},
	{
		pattern = { "*.html", "*.css", "*.yaml", "*.yml" },
		formatter = "prettier",
		args = { "--write" },
	},
}

for _, v in ipairs(list) do
	autocmd(v.pattern, mason_bin_folder .. v.formatter, v.args)
end
