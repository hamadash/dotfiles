return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy", -- Or `LspAttach`
	priority = 1000, -- needs to be loaded in first
	config = function()
		require("tiny-inline-diagnostic").setup()
		vim.diagnostic.config({
			-- virtual_text = { pos = "right_align" },
			virtual_text = false,
		})
	end,
}
