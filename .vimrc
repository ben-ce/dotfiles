"tmux mouse support
set mouse=a

"appearance
set number
syntax on

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
set encoding=UTF-8
let g:airline_theme='angr'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" dont let airline overwrite the loaded tmuxline config
let g:airline#extensions#tmuxline#enabled = 0

"tmuxline plugin
call plug#begin('~/.vim/plugged')
    Plug 'edkolev/tmuxline.vim'
call plug#end()
