-- keymap reference
--[[
"" (an empty string)	mapmode-nvo	Normal, Visual, Select, Operator-pending
"n" Normal	:nmap
"v" Visual and Select
"s" Select	:smap
"x" Visual	:xmap
"o" Operator-pending
"!" Insert and Command-line
"i" Insert	:imap
"l" Insert, Command-line, Lang-Arg
"c" Command-line
"t" Terminal
--]]

local function set_keymap(mode, key, command, desc, expr)
	vim.api.nvim_set_keymap(mode, key, command, { desc = desc, noremap = true, silent = true, expr = expr })
end

-- リーダーキー
vim.g.mapleader = " "

-- ハイライト検索
set_keymap("n", "<Esc>", "<CMD>nohlsearch<CR>", "Unhighlight")

-- ターミナル
set_keymap("t", "<ESC><ESC>", [[<C-\><C-n>]], "Exit terminal mode")

-- ノーマルモードに変更
set_keymap("i", "jj", "<ESC>", "Switch to normal mode")

-- カーソル移動
set_keymap("n", "ss", "^", "Move to beginning of the line")
set_keymap("n", "''", "$", "Move to end of the line")

-- 行移動
set_keymap("n", "<M-j>", "<Cmd>move .+1<CR>==", "")
set_keymap("n", "<M-k>", "<Cmd>move .-2<CR>==", "")
set_keymap("x", "<M-j>", ":move '>+1<CR>gv=gv", "")
set_keymap("x", "<M-k>", ":move '<-2<CR>gv=gv", "")

-- 現在のファイルの相対パスをコピー
set_keymap("n", "<Leader>cfp", "<Cmd>let @*=expand('%')<CR>", "Copy current file relative path")

-- quickfix
set_keymap("n", "[q", "<CMD>cprevious<CR>", "Move previous quickfix")
set_keymap("n", "]q", "<CMD>cnext<CR>", "Move next quickfix")
