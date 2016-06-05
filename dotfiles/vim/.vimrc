"""""""""""""""
" NerdTree 
"""""""""""""""
autocmd vimenter * NERDTree
let NERDTreeShowHidden=1


"""""""""""""""
" Vim-plug
"""""""""""""""
"let g:plug_url_format = 'git@github.com:%s.git'
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
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
