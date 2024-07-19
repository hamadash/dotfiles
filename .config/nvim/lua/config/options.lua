-- 文字コード
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- 24bitカラー
vim.opt.termguicolors = true

-- ヘルプの言語
vim.opt.helplang = "ja"

-- 行、列
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- 行の先頭、行末から前後の行にカーソルを移動
vim.opt.whichwrap = "h,l,<,>,[,],~"

-- マウス
vim.opt.mouse = "a"

-- クリップボード
vim.opt.clipboard = "unnamedplus"

vim.opt.splitright = true
vim.opt.splitbelow = true

-- タブ、インデント
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- 検索
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- 補完入力
vim.opt.completeopt = "menuone,noinsert"

-- タブ等の可視化
vim.opt.list = true
vim.opt.listchars:append("tab:»-")
vim.opt.listchars:append("eol:↲")
