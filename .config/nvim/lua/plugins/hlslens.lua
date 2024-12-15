return {
	"kevinhwang91/nvim-hlslens",
	config = function()
		-- NOTE: この記述がないと VSCode で読み込まれない。
		require("hlslens").setup()
	end,
}
