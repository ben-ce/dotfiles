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
    Plug 'vim-airline/vim-airline'
"    Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    Plug 'arcticicestudio/nord-vim'
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

colorscheme nord

autocmd vimenter * NERDTree | wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
