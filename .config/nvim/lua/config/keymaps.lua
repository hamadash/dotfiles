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

	local options = {
		noremap = true,
		silent = true,
		expr = opts.expr or false,
		desc = opts.desc,
	}

	-- modesが文字列の場合、リストに変換
	if type(modes) == "string" then
		modes = { modes }
	end

	for _, mode in ipairs(modes) do
		-- command に関数も渡せるように vim.keymap.set を使う
		vim.keymap.set(mode, key, command, options)
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

-- インデント時に選択範囲を解除しない。
set_keymap("x", ">", ">gv", { desc = "Indent and keep selection." })
set_keymap("x", "<", "<gv", { desc = "Unindent and keep selection." })

-- Visual モードでペーストしたときにレジスタを上書きせず、連続でペーストできるようにする。
set_keymap("x", "p", '"_dP')

-- 括弧の始点、終点の移動
set_keymap("n", "M", "%", { desc = "Jump bracket" })

-- x で削除してもレジスタに入れない
set_keymap("n", "x", '"_x', { desc = "Delete without yanking" })

-- c でカットしてもレジスタに入れない
set_keymap("n", "c", '"_c', { desc = "Cut without yanking" })

-- U で redo
set_keymap("n", "U", "<C-r>", { desc = "Redo" })

-- Visual コピー時にカーソル位置を維持する。
set_keymap("x", "y", "mzy`z", { desc = "Keep cursor position when visual copied." })

-- カーソルを移動せずにファイル全体をヤンク, P でペーストしたときに余計な空白行が入らないようにヤンクしている
set_keymap(
	"n",
	"<Leader>ya",
	[[:%y | let @" = substitute(@", '\n\s*$', '', '')<CR>]],
	{ desc = "Yank all in this file" }
)

-- 直近で閉じたバッファを開く
set_keymap("n", "<Leader>ro", "<C-^>", { desc = "Reopen recent closed buffer." })

-- Cursor で開く
-- see: .config/nvim/lua/utils/cursor.lua
set_keymap("n", "<Leader>oc", "<CMD>Cursor<CR>", { desc = "Open current file in Cursor." })

-- q をプレフィックスキーにする
-- see: https://zenn.dev/vim_jp/articles/43d021f461f3a4#q%E3%82%92%E3%83%97%E3%83%AC%E3%83%95%E3%82%A3%E3%83%83%E3%82%AF%E3%82%B9%E3%81%AB%E3%81%99%E3%82%8B
set_keymap(
	"n",
	"<script><expr> q",
	"empty(reg_recording()) ? '<sid>(q)' : 'q'",
	{ desc = "Use as prefix unless recording macro." }
)
set_keymap("n", "<sid>(q)q", "qq", { desc = "Start macro recording when not using q as prefix." })

-- 行頭のインデントを除いた内容をヤンクする
local function yank_trimmed_line()
	local line = vim.api.nvim_get_current_line()

	-- 先頭の空白を削る
	local trimmed = line:gsub("^%s+", "")

	-- 無名レジスタ (") に linewise でセット
	vim.fn.setreg('"', trimmed, "l")
	-- システムクリップボード側にも同じ内容をセット
	vim.fn.setreg("+", trimmed, "l")
end

set_keymap("n", "gy", yank_trimmed_line, { desc = "Yank line without indent." })

-- 補完表示
set_keymap("i", "<C-o>", "<C-x><C-o>", { desc = "Trigger omnifunc." })

-- LazyVim settings start --
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
