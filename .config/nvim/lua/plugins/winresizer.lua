return {
  "simeji/winresizer",
  keys = { { "<M-e>", desc = "winresizer" } },
  init = function ()
    vim.g.winresizer_start_key = "<M-e>"

    vim.g.winresizer_vert_resize = 1
    vim.g.winresizer_horiz_resize = 1
  end,
}
