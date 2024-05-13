return {
  "haya14busa/vim-asterisk",
  keys = {
    { "*", [["<Plug>(asterisk-z*)"]], mode = "n", expr = true, replace_keycodes = false },
    { "*", [["<Plug>(asterisk-z*)"]], mode = "v", expr = true, replace_keycodes = false },
    { "<Leader>*", [["<Plug>(asterisk-z*)cgn"]], mode = "n", expr = true, replace_keycodes = false },
    { "<Leader>*", [["<Plug>(asterisk-z*)cgn"]], mode = "v", expr = true, replace_keycodes = false },
  },
}
