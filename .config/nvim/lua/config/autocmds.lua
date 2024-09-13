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
	command = [[call matchadd("ExtraWhitespace", "[\u200B\u3000]")]],
})
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	group = "extra-whitespace",
	pattern = { "*" },
	command = [[highlight default ExtraWhitespace ctermbg=202 ctermfg=202 guibg=salmon]],
})
