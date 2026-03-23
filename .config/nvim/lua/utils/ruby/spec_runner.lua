local M = {}

-- RSpec を実行する
local function run_rspec_command(cmd)
	local Terminal = require("toggleterm.terminal").Terminal
	local rspec_runner = Terminal:new({
		cmd = cmd,
		direction = "float",
		close_on_exit = false,
		on_open = function(term)
			vim.cmd("startinsert!")
		end,
	})
	rspec_runner:toggle()
end

-- 現在の spec ファイル全体を実行
function M.run_spec_file()
	local current_file = vim.fn.expand("%:p")

	if not current_file:match("_spec%.rb$") then
		vim.notify("This is not a spec file", vim.log.levels.WARN)
		return
	end

	local cmd = string.format("bundle exec rspec %s", current_file)
	run_rspec_command(cmd)
end

-- カーソル行の spec を実行
function M.run_spec_line()
	local current_file = vim.fn.expand("%:p")
	local current_line = vim.fn.line(".")

	if not current_file:match("_spec%.rb$") then
		vim.notify("This is not a spec file", vim.log.levels.WARN)
		return
	end

	local cmd = string.format("bundle exec rspec %s:%d", current_file, current_line)
	run_rspec_command(cmd)
end

function M.setup()
	vim.api.nvim_create_user_command("RunSpecFile", function()
		M.run_spec_file()
	end, {})

	vim.api.nvim_create_user_command("RunSpecLine", function()
		M.run_spec_line()
	end, {})
end

return M
