local h = require("util.helper")

return {
  "haya14busa/vim-asterisk",
  init = function()
    h.nmap("*", "<Plug>(asterisk-z*)")
    h.vmap("*", "<Plug>(asterisk-z*)")
  end
}
