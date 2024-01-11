"""""""""""""""
" Vim-plug
" https://github.com/junegunn/vim-plug
"""""""""""""""
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'

" Wakatime
Plug 'wakatime/vim-wakatime'

" https://github.com/AlphaMycelium/pathfinder.vim
" For python integration into neovim: python3 -m pip install --user --upgrade pynvim
" For timers, python3 -m pip install --user --upgrade timers
if has('python3') && has('timers')
  Plug 'AlphaMycelium/pathfinder.vim'
else
  echoerr 'pathfinder.vim is not supported on this Vim installation'
endif

call plug#end()


"""""""""""""""
" General Vim
"""""""""""""""
set number "Show line numbers"

"" Support for accessing X11 clipboard directly from inside vim
"" @see https://github.com/neovim/neovim/issues/583 <-- Neovim specific thread
function! ClipboardYank()
  call system('pbcopy', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('pbpaste')
endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
nnoremap <silent> p :call ClipboardPaste()<cr>p


""""""""""""""""""""""""
" Load Solarized Theme
" https://github.com/altercation/vim-colors-solarized
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


""
" See https://superuser.com/questions/359580/error-adding-cronjobs-in-mac-os-x-lion
""
autocmd filetype crontab setlocal nobackup nowritebackup
