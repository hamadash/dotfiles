-- keymap reference
--[[
'' (an empty string)	mapmode-nvo	Normal, Visual, Select, Operator-pending
'n' Normal	:nmap
'v' Visual and Select
's' Select	:smap
'x' Visual	:xmap
'o' Operator-pending
'!' Insert and Command-line
'i' Insert	:imap
'l' Insert, Command-line, Lang-Arg
'c' Command-line
't' Terminal
--]]

local default_keymap_opts = { noremap = true }
local function keymap_opts_with(desc)
  return { desc = desc, noremap = true }
end

vim.g.mapleader = ' '

vim.opt.number = true

vim.opt.mouse = 'a'

vim.opt.clipboard = 'unnamedplus'

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.termguicolors = true

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', default_keymap_opts)

vim.keymap.set('t', '<ESC><ESC>', [[<C-\><C-n>]], keymap_opts_with('Exit terminal mode'))

vim.keymap.set('i', 'jj', '<ESC>', {noremap = true})
vim.keymap.set('n', '<C-q>', ':q<CR>', default_keymap_opts)
vim.keymap.set('n', 'ss', '^', default_keymap_opts)
vim.keymap.set('n', ';;', '$', default_keymap_opts)

