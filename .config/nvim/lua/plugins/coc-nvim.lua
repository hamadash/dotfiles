return {
  "neoclide/coc.nvim",
  branch = "release",
  event = "InsertEnter",
  init = function()
    vim.g.coc_global_extensions = {
      "coc-eslint",
      "coc-git",
      "coc-json",
      "coc-lua",
      "coc-markdownlint",
      "coc-prettier",
      "coc-solargraph",
      "coc-sql",
      "coc-tslint-plugin",
      "coc-tsserver",
      "coc-typos",
    }
  end,
  keys = {
    { "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<CR><C-r>=coc#on_enter()<CR>"]], mode = "i", expr = true, replace_keycodes = false },
    { "<Tab>", [[coc#pum#visible() ? coc#pum#next(1) : "<Tab>"]], mode = "i", expr = true, replace_keycodes = false },
    { "<S-Tab>", [[coc#pum#visible() ? coc#pum#prev(1) : "<S-Tab>"]], mode = "i", expr = true, replace_keycodes = false },
  },
}
