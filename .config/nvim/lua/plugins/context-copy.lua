return {
	{
		"hamadash/context-copy.nvim",
		config = function()
			require("context-copy").setup()
		end,
		keys = {
			{ "<Leader>cc", "<Cmd>ContextCopy<CR>", mode = { "n", "x" }, desc = "Copy context (relative path)" },
			{ "<Leader>cC", "<Cmd>ContextCopy!<CR>", mode = { "n", "x" }, desc = "Copy context (absolute path)" },
		},
	},
}
