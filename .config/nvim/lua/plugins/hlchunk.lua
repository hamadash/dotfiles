return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
			},
			indent = {
				enable = true,
				-- TODO: いい感じの色があれば設定したい
				-- style = {},
			},
		})
	end,
}
