return {
  "pechorin/any-jump.vim",
  init = function()
    vim.g.any_jump_disable_default_keybindings = 1
  end,
  keys = {
    { "<Leader>aj", "<CMD>AnyJump<CR>", mode = "n" },
  },
}
