return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPost",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<Leader>hp", "<CMD>Gitsigns preview_hunk<CR>", mode = "n", desc = "Show preview the hunk" },
		{ "<Leader>hs", "<CMD>Gitsigns stage_hunk<CR>", mode = { "n", "v" }, desc = "Stage the hunk" },
		{
			"<Leader>hu",
			"<CMD>Gitsigns undo_stage_hunk<CR>",
			mode = { "n", "v" },
			desc = "Undo the last call of stage hunk",
		},
		{
			"<Leader>hr",
			"<CMD>Gitsigns reset_hunk<CR>",
			mode = { "n", "v" },
			desc = "Reset the lines of the hunk",
		},
	},
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "*" },
				delete = { text = "-" },
				topdelete = { text = "-" },
				changedelete = { text = "*" },
			},
			preview_config = {
				border = "single",
				style = "minimal",
			},
		})
	end,
}
