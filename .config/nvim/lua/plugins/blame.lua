return {
	"FabijanZulj/blame.nvim",
	lazy = false,
	keys = {
		{ "<Leader>gb", "<CMD>BlameToggle<CR>", mode = "n", desc = "Show blame window" },
	},
	config = function()
		require("blame").setup({
			format_fn = require("blame.formats.default_formats").date_message,
			date_format = "%Y-%m-%d",
		})
	end,
}
