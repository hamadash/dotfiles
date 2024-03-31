return {
  "terryma/vim-multiple-cursors",
  init = function()
    vim.g.multi_cursor_use_default_mapping=0

    -- Default mapping
    vim.g.multi_cursor_start_word_key      = "<M-d>"
    vim.g.multi_cursor_select_all_word_key = "<M-l>"
    vim.g.multi_cursor_start_key           = "g<M-d>"
    vim.g.multi_cursor_select_all_key      = "g<M-l>"
    vim.g.multi_cursor_next_key            = "<M-d>"
    vim.g.multi_cursor_prev_key            = "<M-u>"
    vim.g.multi_cursor_skip_key            = "<M-x>"
    vim.g.multi_cursor_quit_key            = "<Esc>"
  end,
}
