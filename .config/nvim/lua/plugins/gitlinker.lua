-- カーソル行の最新コミットハッシュを取得
local function get_current_line_commit()
	local line = vim.fn.line(".")
	local file = vim.fn.expand("%:p")
	local cmd = string.format("git blame -L %d,%d --porcelain %s", line, line, vim.fn.shellescape(file))
	local output = vim.fn.system(cmd)
	local commit = vim.split(output, "\n")[1]:match("^(%w+)")
	return commit
end

return {
	"linrongbin16/gitlinker.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "GitLink",
	keys = {
		{
			"<Leader>gl",
			function()
				local commit = get_current_line_commit()
				require("gitlinker").link({
					rev = commit,
					action = require("gitlinker.actions").clipboard,
				})
			end,
			mode = { "n", "v" },
			desc = "Copy git permalink to clipboard (line's commit)",
		},
		{
			"<Leader>gL",
			function()
				local commit = get_current_line_commit()
				require("gitlinker").link({
					rev = commit,
					action = require("gitlinker.actions").system,
				})
			end,
			mode = { "n", "v" },
			desc = "Open git permalink in browser (line's commit)",
		},
	},
	opts = {},
}
