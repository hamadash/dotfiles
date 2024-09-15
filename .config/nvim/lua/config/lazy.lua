-- see: https://www.lazyvim.org/configuration/lazy.nvim
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
			{ import = "plugins.surround" },
			{ import = "plugins.vim-asterisk" },
			{ import = "plugins.vim-bracketed-paste" },
			{ import = "plugins.vim-translator" },
		},
	})
else
	require("lazy").setup({
		spec = {
			-- TODO: 後で整理する
			-- そもそも LazyVim をやめたい
			-- 一旦 LazyVim のデフォルトでインストールされるプラグインを全部無効化する
			{ "folke/trouble.nvim", enabled = false },
			{ "folke/flash.nvim", enabled = false },
			{ "folke/lazydev.nvim", enabled = false },
			{ "folke/noice.nvim", enabled = false },
			{ "catppuccin/nvim", enabled = false },
			{ "hrsh7th/cmp-path", enabled = false },
			{ "rcarriga/nvim-notify", enabled = false },
			{ "stevearc/dressing.nvim", enabled = false },
			{ "rafamadriz/friendly-snippets", enabled = false },
			{ "Abstract-IDE/grug-far.nvim", enabled = false },
			{ "luvit/luvit-meta", enabled = false },
			{ "echasnovski/mini.ai", enabled = false },
			{ "echasnovski/mini.icons", enabled = false },
			{ "echasnovski/mini.pairs", enabled = false },
			{ "nvim-neo-tree/neo-tree.nvim", enabled = false },
			{ "MunifTanjim/nui.nvim", enabled = false },
			{ "norcalli/nvim-snippets", enabled = false },
			{ "folke/persistence.nvim", enabled = false },
			{ "nvim-telescope/telescope-fzf-native.nvim", enabled = false },
			{ "folke/todo-comments.nvim", enabled = false },
			{ "JoosepAlviste/nvim-ts-context-commentstring", enabled = false },
			-- add LazyVim and import its plugins
			{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
			-- import/override with your plugins
			{ import = "plugins" },
		},
		install = { colorscheme = { "tokyonight", "habamax" } },
		checker = {
			enabled = true,
		},
		performance = {
			rtp = {
				disabled_plugins = {
					"gzip",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
				},
			},
		},
		ui = {
			border = "single",
		},
	})
end
