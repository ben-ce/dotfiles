"tmux mouse support
set mouse=a

"appearance
set number
syntax on
set cursorline

"encoding
set encoding=utf-8

"tab config
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
retab

"airline config
let g:airline_theme='nord'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" dont let airline overwrite the loaded tmuxline config
let g:airline#extensions#tmuxline#enabled = 0

" Trun on python-mode plugin
let g:pymode = 1
let g:pymode_options = 1
let g:pymode_lint = 1
let g:pymode_lint_on_fly = 1
let g:pymode_rope = 1
let g:pymode_rope_completion = 1
set completeopt=menuone,noinsert
let g:pymode_rope_completion_bind = '<C-Space>'


"tmuxline plugin
let g:pymode_rope_completion = 1
call plug#begin('~/.vim/plugged')
    Plug 'edkolev/tmuxline.vim'
    Plug 'edkolev/promptline.vim'
    Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    Plug 'arcticicestudio/nord-vim'
call plug#end()

colorscheme nord
