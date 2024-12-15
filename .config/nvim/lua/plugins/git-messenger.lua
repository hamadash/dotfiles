return {
	"rhysd/git-messenger.vim",
	cmd = "GitMessenger",
	init = function()
		vim.g.git_messenger_floating_win_opts = { border = "single" }
	end,
	keys = {
		{ "<C-k>", "<CMD>GitMessenger<CR>", mode = "n", desc = "Show git blame on the current line" },
	},
}
