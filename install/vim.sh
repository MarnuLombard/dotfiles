#! /bin/bash

############################################################
# Vim and related dependencies install
# See: https://www.vim.org
############################################################
# Requires: dotfiles.sh

echo "--------------------------------------
    Starting Vim installation
--------------------------------------"

# Set vim as default text editor
if [ X"${DISTRO}" == X'UBUNTU' ]; then
  sudo update-alternatives --install /usr/bin/editor editor $(which vim) 1
  sudo update-alternatives --set editor $(which vim)
fi

echo '
# Set vim as default text editor
export EDITOR=vim' >>$FISH_EXPORT

# Install Pathogen
# See: https://github.com/tpope/vim-pathogen
if [ ! -f ~/.vim/autoload ]; then
  mkdir -p ~/.vim/autoload
fi
if [ ! -f ~/.vim/bundle ]; then
  mkdir -p ~/.vim/bundle
fi
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install Vim Plug
# See: https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Nerdtree
# See: https://github.com/scrooloose/nerdtree
cd ~/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git
