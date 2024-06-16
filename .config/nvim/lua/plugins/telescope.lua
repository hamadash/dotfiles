return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    cmd = "Telescope",
    keys = {
      { "<Leader>ff", "<CMD>Telescope find_files<CR>",                                                mode = "n", desc = "Find files" },
      { "<Leader>fg", "<CMD>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", mode = "n", desc = "Live grep" },
      { "<Leader>fk", "<CMD>Telescope keymaps<CR>",                                                   mode = "n", desc = "Show keymaps" },
      { "<Leader>fh", "<CMD>Telescope help_tags<CR>",                                                 mode = "n", desc = "Show help tags" },
      { "<Leader>fc", "<CMD>Telescope git_commits<CR>",                                               mode = "n", desc = "Show git commits" },
      { "<Leader>fb", "<CMD>Telescope buffers<CR>",                                                   mode = "n", desc = "Show buffers" },
      {
        "<Leader>fbb",
        function()
          return "<CMD>Telescope file_browser cwd=" .. vim.fn.expand("%:p:h") .. "<CR>"
        end,
        mode = "n",
        expr = true,
        silent = true,
        desc = "File browser in current directory"
      },
    },
    config = function()
      local telescope = require("telescope")
      local telescope_actions = require("telescope.actions")
      local lga_actions = require("telescope-live-grep-args.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["<C-n>"] = "cycle_history_next",
              ["<C-p>"] = "cycle_history_prev",
              ["<C-d>"] = telescope_actions.delete_buffer,
            },
            n = {
              ["q"] = "close",
              ["<C-d>"] = telescope_actions.delete_buffer,
            },
          },
          prompt_prefix = " ",
          layout_config = {
            vertical = {
              width = 0.8,
              height = 0.9,
              prompt_position = "bottom",
            },
          },
          preview = { treesitter = false },
          file_ignore_patterns = { "^.git/" },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
        },
        pickers = {
          find_files = { hidden = true },
          live_grep = {},
        },
        extensions = {
          file_browser = {
            hidden = true,
            respect_gitignore = false,
          },
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              },
            },
          }
        }
      })

      telescope.load_extension("ui-select")
      telescope.load_extension("file_browser")
      telescope.load_extension("live_grep_args")
    end
  }
}
