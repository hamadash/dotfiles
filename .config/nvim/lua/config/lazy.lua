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
			-- LazyVim をやめたいが、 lazygit の設定が便利なのでとりあえず入れている
			-- ただ、 LazyVim のデフォルトでインストールされるプラグインは不要なことが多いので、一旦不要なものは全部無効化する
			{ "folke/trouble.nvim", enabled = false }, -- 要らない
			{ "folke/flash.nvim", enabled = false }, -- 便利だけど要らない
			{ "folke/lazydev.nvim", enabled = false }, -- 要らない
			{ "folke/noice.nvim", enabled = false },
			{ "catppuccin/nvim", enabled = false }, -- 要らない
			{ "hrsh7th/cmp-path", enabled = false },
			{ "rcarriga/nvim-notify", enabled = false },
			{ "stevearc/dressing.nvim", enabled = false }, -- たぶん要らない
			{ "rafamadriz/friendly-snippets", enabled = false }, -- 要らない
			{ "Abstract-IDE/grug-far.nvim", enabled = false }, -- 要らない
			{ "luvit/luvit-meta", enabled = false }, -- 要らない
			{ "echasnovski/mini.ai", enabled = false },
			{ "echasnovski/mini.icons", enabled = false },
			{ "echasnovski/mini.pairs", enabled = false },
			{ "nvim-neo-tree/neo-tree.nvim", enabled = false }, -- とりあえず要らない
			{ "MunifTanjim/nui.nvim", enabled = false }, -- とりあえず今は要らない
			{ "norcalli/nvim-snippets", enabled = false },
			{ "folke/persistence.nvim", enabled = false },
			-- add LazyVim and import its plugins
			{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
			-- import/override with your plugins
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
