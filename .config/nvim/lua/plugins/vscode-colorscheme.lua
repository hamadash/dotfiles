return {
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- ~/development 配下を開く場合は vscode カラーにする。
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					local cwd = vim.fn.getcwd()
					local dev_path = vim.fn.expand("~/development")
					if cwd:sub(1, #dev_path) == dev_path then
						vim.cmd.colorscheme("vscode")
					end
				end,
			})
		end,
	},
}
