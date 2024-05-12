local augroup = vim.api.nvim_create_augroup("AutoCommands", {})

-- 常にインサートモードでTerminalを開く
-- ref: https://zenn.dev/ryo_kawamata/articles/improve-neovmi-terminal
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = augroup,
  pattern = { "term://*" },
  command = "startinsert",
})

-- Neovimの操作以外でファイルが変更されたときに自動で再読み込みする
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter" }, {
  pattern = "*",
  command = "checktime",
})
