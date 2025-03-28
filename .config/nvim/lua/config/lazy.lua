-- see: https://lazy.folke.io/installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
	require("lazy").setup({
		spec = {
			{ import = "plugins.accelerated-jk" }, -- TODO: VSCode で効いてないかも
			{ import = "plugins.aerial" },
			{ import = "plugins.any-jump" },
			{ import = "plugins.clever-f" },
			{ import = "plugins.colorizer" },
			{ import = "plugins.comment" },
			{ import = "plugins.dial" },
			{ import = "plugins.git" },
			{ import = "plugins.hlslens" },
			{ import = "plugins.hop" },
			{ import = "plugins.nvim-anywise-reg" },
			{ import = "plugins.open-browser" },
			{ import = "plugins.quick-scope" },
			{ import = "plugins.ruby-fqn" },
			{ import = "plugins.surround" },
			{ import = "plugins.text-case" },
			{ import = "plugins.vim-asterisk" },
			{ import = "plugins.vim-bracketed-paste" },
			{ import = "plugins.vim-maketable" },
			{ import = "plugins.vim-translator" },
		},
	})
else
	require("lazy").setup({
		spec = {
			{ import = "plugins" },
		},
		checker = {
			enabled = true,
		},
		ui = {
			border = "single",
		},
	})
end
