#! /usr/bin/env fish

############################################################
# Install fonts, for Linux - distro-dependant
############################################################
# Requires: brew.sh, distro.sh

echo "--------------------------------------
    Starting Fonts installation
--------------------------------------"

if [ X"${KERNEL_NAME}" == X'DARWIN' ]; then
  brew cask install caskroom/fonts/font-hack

elif [ X"${KERNEL_NAME}" == X'LINUX' ]; then
  if [ X"${DISTRO}" == X'UBUNTU' ]; then
    sudo apt-get install -y fonts-hack-ttf

  elif [ X"${DISTRO}" == X'FEDORA' ]; then
    sudo dnf -y install dnf-plugins-core
    sudo dnf -y copr enable heliocastro/hack-fonts
    sudo dnf -y install hack-fonts
  else
    echo "Cannot install Hack font automatically on this system. Please see https://github.com/chrissimpkins/Hack/blob/master/docs/INSTALLATION.md#manual-installation-on-linux"
    exit 255
  fi
fi

echo 'Done.'
