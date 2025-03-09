return {
	{
		"hamadash/ruby-fqn.nvim",
		config = function()
			require("ruby-fqn")
		end,
		keys = {
			{ "<Leader>crn", "<Cmd>RubyFQN CopyName<CR>", mode = "n" },
		},
	},
}
