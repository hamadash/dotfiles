local h = require("util.helper")

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

local function opts_with(desc)
  return { desc = desc, noremap = true }
end

-- リーダーキー
vim.g.mapleader = " "

-- タブ
-- h.nmap("]t", "<CMD>tabnext<CR>", opts_with("Switch to next tab"))
-- h.nmap("[t", "<CMD>tabprevious<CR>", opts_with("Switch to previous tab"))
-- h.nmap("<Leader>tn", "<CMD>tabnew<CR>", opts_with("Create new tab"))
-- h.nmap("<Leader>tw", "<CMD>tabclose<CR>", opts_with("Close tab"))

-- ハイライト検索
h.nmap("<Esc>", "<cmd>nohlsearch<CR>", opts_with("Unhilight"))

-- ターミナル
h.tmap("<ESC><ESC>", [[<C-\><C-n>]], opts_with("Exit terminal mode"))

-- ノーマルモードに変更
h.imap("jj", "<ESC>", opts_with("Switch to normal mode"))

-- カーソル移動
h.nmap("ss", "^", opts_with("Move to beginning of the line"))
h.nmap("''", "$", opts_with("Move to end of the line"))

-- 行移動
h.nmap("j", "gj", opts_with(""))
h.nmap("k", "gk", opts_with(""))
h.nmap("gj", "j", opts_with(""))
h.nmap("gk", "k", opts_with(""))
h.nmap("<M-j>", "<Cmd>move .+1<CR>==", opts_with(""))
h.nmap("<M-k>", "<Cmd>move .-2<CR>==", opts_with(""))
-- vim.keymap.set("x", "<M-j>", ":move '>+1<CR>gv=gv")
-- vim.keymap.set("x", "<M-k>", ":move '<-2<CR>gv=gv")

-- 現在のファイルの相対パスをコピー
h.nmap("<Leader>cfp", "<Cmd>let @*=expand('%')<CR>", opts_with("Copy current file relative path"))

-- quickfix
h.nmap("[q", "<CMD>cprevious<CR>", opts_with("Move previous quickfix."))
h.nmap("]q", "<CMD>cnext<CR>", opts_with("Move next quickfix."))
