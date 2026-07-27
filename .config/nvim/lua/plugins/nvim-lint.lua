return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")

		lint.linters.textlint = {
			cmd = "textlint",
			stdin = true,
			stream = "both",
			ignore_exitcode = true,
		}

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			jsx = { "eslint_d" },
			tsx = { "eslint_d" },
			html = { "htmlhint" },
			json = { "jsonlint" },
			ruby = { "ruby", "rubocop" },
			sh = { "shellcheck" },
			sql = { "sqlfluff" },
			yaml = { "yamllint" },
			zsh = { "zsh" },
		}

		-- InsertLeave は含めない。インサートモードを抜けるたびに linter プロセスが起動し、
		-- Ruby では ruby(145ms) + rubocop(858ms) + cspell(108ms) で 1 回あたり約 1.1 秒かかるため。
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = function()
				require("lint").try_lint()

				-- 全てのファイルで実行したい lint
				require("lint").try_lint({ "cspell" })
			end,
		})
	end,
}
