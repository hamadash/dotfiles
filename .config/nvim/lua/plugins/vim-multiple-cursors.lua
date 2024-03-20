return {
  "terryma/vim-multiple-cursors",
  init = function()
    vim.g.multi_cursor_use_default_mapping=0

    -- Default mapping
    vim.g.multi_cursor_start_word_key      = "<C-d>"
    vim.g.multi_cursor_select_all_word_key = "<C-l>"
    vim.g.multi_cursor_start_key           = "g<C-d>"
    vim.g.multi_cursor_select_all_key      = "g<C-l>"
    vim.g.multi_cursor_next_key            = "<C-d>"
    vim.g.multi_cursor_prev_key            = "<C-u>"
    vim.g.multi_cursor_skip_key            = "<C-x>"
    vim.g.multi_cursor_quit_key            = "<Esc>"
  end,
}
