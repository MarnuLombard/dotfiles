#! /bin/bash

############################################################
# Vim and related dependencies install
# See: https://www.vim.org
############################################################
# Requires: null

echo "--------------------------------------
    Linking dotfiles
--------------------------------------"

# Set BASEDIR
# As per http://www.anishathalye.com/2014/08/03/managing-your-dotfiles/
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTDIR=${BASEDIR}/dotfiles

# Vim
ln -s ${DOTDIR}/vim/.vimrc ~/
ln -s ${DOTDIR}/vim/.vim ~/

# Fish & Oh My Fish
mkdir -p ~/.config/fish
mkdir -p ~/.config/omf
ln -s ${DOTDIR}/fish/config.fish ~/.config/fish/
ln -s ${DOTDIR}/fish/exports.fish ~/.config/omf/before.init.fish
ln -s ${DOTDIR}/fish/functions.fish ~/.config/fish/init.fish

# Git
ln -s ${DOTDIR}/git/.gitconfig ~/
ln -s ${DOTDIR}/git/.gitignore_global ~/

# Ssh
ln -s ${DOTDIR}/ssh/.ssh ~/

echo "Done."
