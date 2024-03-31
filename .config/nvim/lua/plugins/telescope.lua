local h = require("util.helper")

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim"
    },
    cmd = "Telescope",
    init = function()
      h.nmap("<Leader>ff", "<CMD>Telescope find_files<CR>")
      h.nmap("<Leader>fg", "<CMD>Telescope live_grep<CR>")
      h.nmap("<Leader>fk", "<CMD>Telescope keymaps<CR>")
      h.nmap("<Leader>fh", "<CMD>Telescope help_tags<CR>")
      h.nmap("<Leader>fc", "<CMD>Telescope git_commits<CR>")
      h.nmap("<Leader>fb", "<CMD>Telescope buffers<CR>")
      h.nmap("<Leader>fbb", function()
        return "<CMD>Telescope file_browser cwd=" .. vim.fn.expand("%:p:h") .. "<CR>"
      end, { silent = true, expr = true })
    end,
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
                  ["<C-j>"] = "move_selection_next",
                  ["<C-k>"] = "move_selection_previous",
                  ["<C-n>"] = "cycle_history_next",
                  ["<C-p>"] = "cycle_history_prev",
                  ["<C-q>"] = "close",
            },
            n = {
                  ["q"] = "close",
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
        }
      })

      telescope.load_extension("ui-select")
      telescope.load_extension("file_browser")
    end
  }
}
