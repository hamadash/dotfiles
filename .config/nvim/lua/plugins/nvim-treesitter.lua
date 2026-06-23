return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",

	config = function()
		local ts = require("nvim-treesitter")

		ts.setup()

		ts.install({
			"bash",
			"css",
			"dockerfile",
			"graphql",
			"html",
			"javascript",
			"json",
			"json5",
			"lua",
			"markdown",
			"markdown_inline",
			"regex",
			"ruby",
			"sql",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		})
	end,
}
