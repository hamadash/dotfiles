return {
	"github/copilot.vim",
	lazy = false,
	config = function()
		vim.g.copilot_no_tab_map = true
		vim.api.nvim_set_keymap("i", "<C-L>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
	end,
}
