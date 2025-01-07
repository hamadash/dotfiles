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

local function set_keymap(modes, key, command, opts)
	opts = opts or {}

	local options = { noremap = true, silent = true, expr = opts.expr or false, desc = opts.desc }

	-- modesが文字列の場合、リストに変換
	if type(modes) == "string" then
		modes = { modes }
	end

	for _, mode in ipairs(modes) do
		vim.api.nvim_set_keymap(mode, key, command, options)
	end
end

-- リーダーキー
vim.g.mapleader = " "

-- ハイライト検索
set_keymap("n", "<Esc>", "<CMD>nohlsearch<CR>", { desc = "Unhighlight" })

-- ターミナル
set_keymap("t", "<ESC><ESC>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- ノーマルモードに変更
set_keymap("i", "jj", "<ESC>", { desc = "Switch to normal mode" })

-- カーソル移動
set_keymap("n", "ss", "^", { desc = "Move to beginning of the line" })
set_keymap("v", "ss", "^", { desc = "Move to beginning of the line" })
set_keymap("n", "''", "$", { desc = "Move to end of the line" })
set_keymap("v", "''", "$", { desc = "Move to end of the line" })

-- 現在のファイルの相対パスをコピー
set_keymap("n", "<Leader>cfp", "<Cmd>let @*=expand('%')<CR>", { desc = "Copy current file relative path" })

-- quickfix
set_keymap("n", "[q", "<CMD>cprevious<CR>", { desc = "Move previous quickfix" })
set_keymap("n", "]q", "<CMD>cnext<CR>", { desc = "Move next quickfix" })

-- コピー
set_keymap("n", "Y", "y$", { desc = "Copy from current position to end of line" })

-- 括弧の始点、終点の移動
set_keymap("n", "M", "%", { desc = "Jump bracket" })

-- x で削除してもレジスタに入れない
set_keymap("n", "x", '"_x', { desc = "Delete without yanking" })

-- カーソルを移動せずにファイル全体をヤンク, P でペーストしたときに余計な空白行が入らないようにヤンクしている
set_keymap(
	"n",
	"<Leader>ya",
	[[:%y | let @" = substitute(@", '\n\s*$', '', '')<CR>]],
	{ desc = "Yank all in this file" }
)

-- LazyVim setteings start --
-- LazyVim のキーマップが便利なので流用
-- https://www.lazyvim.org/configuration/general#keymaps

-- better up/down
set_keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })
set_keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })
set_keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })
set_keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })

-- Move Lines
set_keymap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
set_keymap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
set_keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
set_keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
set_keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
set_keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- lazy
set_keymap("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- save file
set_keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- quit
set_keymap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
-- LazyVim settings end --
