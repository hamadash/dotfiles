return {
	"lambdalisue/nvim-aibo",
	keys = {
		{ "<leader>cc", "<cmd>Aibo -opener=vsplit -toggle claude<cr>", desc = "Toggle Aibo with Claude (vsplit)" },
	},
	config = function()
		require("aibo").setup()
	end,
}
