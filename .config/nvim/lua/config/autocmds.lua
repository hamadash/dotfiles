local augroup = vim.api.nvim_create_augroup("AutoCommands", {})

-- 常にインサートモードでTerminalを開く
-- ref: https://zenn.dev/ryo_kawamata/articles/improve-neovmi-terminal
vim.api.nvim_create_autocmd({ "TermOpen" }, {
	group = augroup,
	pattern = { "term://*" },
	command = "startinsert",
})

-- 外部でファイルが変更されたときに自動で再読み込みする
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter" }, {
	pattern = "*",
	command = "checktime",
})

-- ゼロ幅スペース、全角スペースを可視化
vim.api.nvim_create_augroup("extra-whitespace", {})
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter" }, {
	group = "extra-whitespace",
	pattern = { "*" },
	callback = function()
		-- matchadd はウィンドウローカルなので、ガードしないと同じウィンドウに再入するたびに
		-- 重複登録され、再描画ごとに評価される正規表現が際限なく増える
		-- 計測: ウィンドウ往復 10 回で match 数が 1 から 11 に増加
		if vim.w.extra_whitespace_match then
			return
		end
		vim.w.extra_whitespace_match = vim.fn.matchadd("ExtraWhitespace", "[\u{200B}\u{3000}]")
	end,
})
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	group = "extra-whitespace",
	pattern = { "*" },
	command = [[highlight default ExtraWhitespace ctermbg=202 ctermfg=202 guibg=salmon]],
})

-- LazyVim のデフォルト値を上書き
-- options.lua だと読み込み順的に上書きできないため、ここで指定する
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.opt.relativenumber = false
	end,
})
