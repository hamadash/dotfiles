set shell=/bin/zsh
set shiftwidth=2
set tabstop=2
" タブをスペースにする
set expandtab
" ワードラッピング(0=なし)
set textwidth=0
" 自動インデント :set paste で解除可能
set autoindent
" Search のハイライト
set hlsearch
" クリップボードに登録
set clipboard=unnamed
syntax on

call plug#begin()
Plug 'ntk148v/vim-horizon'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" =================================

" vim-horizon

" if you don't set this option, this color might not correct
set termguicolors

colorscheme horizon

" lightline
let g:lightline = {}
let g:lightline.colorscheme = 'horizon'

" =================================

" nerdtree

nnoremap <C-n> :NERDTree<CR>


" =================================

" gitgutter

let g:gitgutter_highlight_lines = 1
