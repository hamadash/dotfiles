local h = require("util.helper")

return {
  "kinsho/toggleterm.nvim",
  version = "*",
  init = function ()
    h.nmap("<C-t>", "<Cmd>ToggleTerm<CR>", { silent = true, noremap = true })
    h.tmap("<C-t>", "<C-\\><C-n><Cmd>ToggleTerm<CR>", { silent = true, noremap = true })
  end,
  opts = {
    size = 20,
  },
}
