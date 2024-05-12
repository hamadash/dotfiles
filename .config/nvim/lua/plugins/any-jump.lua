local h = require("util.helper")

return {
  "pechorin/any-jump.vim",
  init = function ()
    vim.g.any_jump_disable_default_keybindings = 1

    h.nmap("<Leader>aj", "<Cmd>AnyJump<CR>", { silent = true, noremap = true })
  end,
}
