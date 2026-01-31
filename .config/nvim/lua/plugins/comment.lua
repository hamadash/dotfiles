return {
	"numToStr/Comment.nvim",
	keys = {
		{ "<C-_>", "<Plug>(comment_toggle_linewise_current)", mode = "n" },
		{ "<C-_>", "<Plug>(comment_toggle_linewise_visual)", mode = "v" },
		-- _ だと / でコメントアウトできないことがあったので一応定義
		{ "<C-/>", "<Plug>(comment_toggle_linewise_current)", mode = "n" },
		{ "<C-/>", "<Plug>(comment_toggle_linewise_visual)", mode = "v" },
	},
	lazy = false,
}
