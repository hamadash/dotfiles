return {
	"hamadash/rails-schema.nvim",
	cmd = { "RailsSchema", "RailsSchemaCurrent", "RailsSchemaSearch" },
	keys = {
		{ "<leader>rs", "<cmd>RailsSchemaCurrent<cr>", desc = "Rails schema: current model" },
		{ "<leader>rS", "<cmd>RailsSchemaSearch<cr>", desc = "Rails schema: search" },
	},
	config = function()
		require("rails-schema").setup({
			title = "Rails Schema",
			float = { width = 0.65, height = 0.7, border = "rounded" },
		})
	end,
}
