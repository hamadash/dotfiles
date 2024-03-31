local h = require("util.helper")

return {
  "neoclide/coc.nvim",
  branch = "release",
  init = function()
    h.imap("<Tab>", "coc#pum#visible() ? coc#pum#next(1) : \"\\<Tab>\"", {noremap = true, expr = true, silent = true})
    h.imap("<S-Tab>", "coc#pum#visible() ? coc#pum#prev(1) : \"\\<S-Tab>\"", {noremap = true, expr = true, silent = true})
    h.imap("kk", "coc#pum#visible() ? coc#pum#confirm() : \"kk\"", {noremap = true, expr = true, silent = true})
  end,
  config = function()
  end
}
