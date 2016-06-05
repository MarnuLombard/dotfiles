#! /bin/bash

############################################################
# Git installation & Config
############################################################
# Requires: dotfiles.sh

echo "--------------------------------------
    Starting Git installation
--------------------------------------"

if [ X"${KERNEL_NAME}" == X'DARWIN' ]; then
  brew install git

elif [ X"${KERNEL_NAME}" == X'LINUX' ]; then
  if [ X"${DISTRO}" == X'UBUNTU' ]; then
    sudo apt-get install -y git

  elif [ X"${DISTRO}" == X'FEDORA' ]; then
    sudo dnf install -y git
  fi
fi

echo 'Done.'

