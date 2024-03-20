let mapleader = "\<space>"
set shell=/bin/zsh
if !exists('g:vscode')
    set number
end
set showmode
set cursorline
set cursorcolumn
set shiftwidth=2
set tabstop=2
set expandtab
" 自動インデント :set paste で解除可能
set autoindent
set hlsearch
set clipboard=unnamed
syntax on

" noremap
noremap <C-q> :q<CR>
noremap ss ^
noremap ;; $

nnoremap <ESC><ESC> :nohlsearch<CR>

inoremap jj <ESC>

" command
command! SS :so ~/.config/nvim/init.vim

if !exists('g:vscode')
    call plug#begin()
    Plug 'ntk148v/vim-horizon'
    Plug 'preservim/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
    Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    call plug#end()
end

if !exists('g:vscode')
    " vim-horizon

    " if you don't set this option, this color might not correct
    set termguicolors

    colorscheme horizon
end

if !exists('g:vscode')
    " lightline
    let g:lightline = {}
    let g:lightline.colorscheme = 'horizon'
end

if !exists('g:vscode')
    " nerdtree

    " nnoremap <C-n> :NERDTree<CR>
    nnoremap <C-n> <plug>NERDTreeTabsToggle<CR>

    let NERDTreeShowHidden=1

    let g:nerdtree_tabs_open_on_console_startup=1
    " ファイル指定をしたときは非表示にする
    " autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
end

if !exists('g:vscode')
    " telescope

    " Find files using Telescope command-line sugar.
    nnoremap <leader>ff <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files,--glob,!*.git<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>
end

if !exists('g:vscode')
    " ToggleTerm

    lua require("toggleterm").setup()
end

if !exists('g:vscode')
    " fzf

    nnoremap <C-p> :Files<CR>
end

if !exists('g:vscode')
    " gitgutter

    let g:gitgutter_highlight_lines = 1
end
