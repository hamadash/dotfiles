return {
	"linrongbin16/gitlinker.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "GitLink",
	keys = {
		{
			"<Leader>gl",
			"<cmd>GitLink<cr>",
			mode = { "n", "v" },
			desc = "Copy git permalink to clipboard",
		},
		{
			"<Leader>gL",
			"<cmd>GitLink!<cr>",
			mode = { "n", "v" },
			desc = "Open git permalink in browser",
		},
	},
}
