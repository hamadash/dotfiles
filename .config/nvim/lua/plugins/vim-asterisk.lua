local h = require("util.helper")

return {
  "haya14busa/vim-asterisk",
  init = function()
    h.nmap("*", "<Plug>(asterisk-z*)")
    h.vmap("*", "<Plug>(asterisk-z*)")
    h.nmap("<Leader>*", "<Plug>(asterisk-z*)cgn")
    h.vmap("<Leader>*", "<Plug>(asterisk-z*)cgn")
  end
}
