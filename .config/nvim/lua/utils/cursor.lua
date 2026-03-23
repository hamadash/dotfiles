local M = {}

-- NOTE: 起動時のディレクトリをプロジェクトルートとみなす。
local root_cwd = vim.fn.getcwd()

function M.setup()
	vim.api.nvim_create_user_command("Cursor", function()
		local filePath = vim.fn.expand("%:p")
		local relativePath = vim.fn.fnamemodify(filePath, ":.")
		local line = vim.fn.line(".")

		-- Cursor を Neovim と同じプロジェクトルートで起動し、--goto を相対パスで指定する。
		vim.fn.jobstart({
			"cursor",
			root_cwd,
			"--reuse-window",
			"--goto",
			relativePath .. ":" .. line,
		}, {
			cwd = root_cwd,
			detach = true,
		})
	end, {})
end

return M
