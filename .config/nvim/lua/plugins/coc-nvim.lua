return {
  "neoclide/coc.nvim",
  branch = "release",
  event = "InsertEnter",
  keys = {
    { "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<CR><C-r>=coc#on_enter()<CR>"]], mode = "i", expr = true, replace_keycodes = false },
    { "<Tab>", [[coc#pum#visible() ? coc#pum#next(1) : "<Tab>"]], mode = "i", expr = true, replace_keycodes = false },
    { "<S-Tab>", [[coc#pum#visible() ? coc#pum#prev(1) : "<S-Tab>"]], mode = "i", expr = true, replace_keycodes = false },
  },
}
