return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		dim = {},
	},
	keys = {
		{
			"<leader>pk",
			function()
				Snacks.picker()
			end,
			desc = "Open Snacks Picker",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
		-- Other
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle Zoom",
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
	},
}
