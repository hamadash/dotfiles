return {
	"voldikss/vim-translator",
	init = function()
		vim.g.translator_target_lang = "ja"
	end,
	keys = {
		{ "<leader>tl", "<cmd>Translate<cr>", desc = "Translate" },
	},
}
