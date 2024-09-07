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
			{ import = "plugins.any-jump" },
			{ import = "plugins.colorizer" },
			{ import = "plugins.comment" },
			{ import = "plugins.cursorline" },
			{ import = "plugins.hlslens" },
			{ import = "plugins.hop" },
			{ import = "plugins.nvim-anywise-reg" },
			{ import = "plugins.open-browser" },
			{ import = "plugins.scrollbar" },
			{ import = "plugins.surround" },
			{ import = "plugins.vim-asterisk" },
			{ import = "plugins.vim-bracketed-paste" },
			{ import = "plugins.vim-translator" },
			{
				"LazyVim/LazyVim",
			},
		},
	})
else
	require("lazy").setup({
		spec = {
			{ import = "plugins" },
			{
				"LazyVim/LazyVim",
				opts = {
					colorscheme = "tokyonight",
				},
			},
		},
		-- TODO: なぜ書いたのか忘れてしまったため、一旦コメントアウトしているが、しばらくして不要そうなら消す
		-- performance = {
		--   rtp = {
		--     disabled_plugins = {
		--       "netrw",
		--       "netrwPlugin",
		--     },
		--   },
		-- },
		ui = {
			border = "single",
		},
		-- automatically check for plugin updates
		checker = { enabled = true },
	})
end
