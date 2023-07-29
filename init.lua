function req(req) require("plugins/configuracion/" .. req) end

vim.cmd('set clipboard=unnamedplus')


require("plugins/init")
require("teclas/teclas")
require("opciones")


req("nvim-tree")
req("alpha-nvim")
req("autoclose")
req("lualine")
req("nvim-treesitter")
req("cmp")
req("mason")
req("toggle-term")
req("which-key-nvim")


--loada("netrw")
--loada("netrwPlugin")
--loada("netrwsettings")
--loada("netrwfilehandlers")
--loada("gzip")
--loada("zip")
--loada("zipplugin")
--loada("tar")
--loada("tarplugin")
--loada("getscript")
--loada("getscriptplugin")
--loada("vimball")
--loada("vimballplugin")
--loada("2html_plugin")
--loada("logipat")
--loada("rrhelper")
--loada("spellfile_plugin")
--loada("matchit")
