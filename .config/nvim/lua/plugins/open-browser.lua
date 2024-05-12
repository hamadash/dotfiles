local h = require("util.helper")

return {
  "tyru/open-browser.vim",
  init = function ()
    h.nmap("gx", "<Plug>(openbrowser-smart-search)")
  end
}
