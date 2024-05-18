vim.api.nvim_create_augroup("AutoFormat", {})

local current_buffer = vim.api.nvim_eval("expand('%:p')")

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.lua",
	group = "AutoFormat",
	callback = function()
		vim.cmd("silent !~/.local/share/PersonalVim/mason/bin/stylua " .. current_buffer .. " %")
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.cs",
	group = "AutoFormat",
	callback = function()
		vim.cmd(
			"silent !~/.local/share/PersonalVim/mason/bin/dotnet-csharpier "
				.. current_buffer
				.. " --fast --no-msbuild-check %"
		)
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.js", "*.ts", "*.html", "*.json", "*.jsx", "*.tsx", "*.css", "*.yaml", "*.yml" },
	group = "AutoFormat",
	callback = function()
		vim.cmd("silent !~/.local/share/PersonalVim/mason/bin/prettier " .. current_buffer .. " --write %")
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
	callback = function()
		local f = vim.fn.expand("%:p")
		if vim.fn.isdirectory(f) ~= 0 then
			vim.cmd("Neotree current dir=" .. f)
			vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
		end
	end,
})
