"""""""""""""""
" Vim-plug
"""""""""""""""
"let g:plug_url_format = 'git@github.com:%s.git'
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
call plug#end()

"""""""""""""
" Pathogen
""""""""""""
execute pathogen#infect()

"""""""""""""""
" General Vim
"""""""""""""""
set number "Show line numbers

""""""""""""""""""""""""
" Load Solarized Theme
"""""""""""""""""""""""
syntax enable
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
colorscheme solarized

""""""""""""""""""""""""
" NerdTree
"""""""""""""""""""""""
"autocmd vimenter * NERDTree

