#! /bin/bash

############################################################
# Node.js, NPM & related installs
# See: https://nodejs.org, https://www.npmjs.com
############################################################
# Requires: distro.sh, fish.sh

echo "--------------------------------------
    Installing Node & NPM
--------------------------------------"

# Install Node.js
if [ X"${KERNEL_NAME}" == X'DARWIN' ]; then
  brew install node

elif [ X"${KERNEL_NAME}" == X'LINUX' ]; then
  if [ X"${DISTRO}" == X'UBUNTU' ]; then
    sudo apt-get install -y build-essential
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
    sudo apt-get install -y nodejs

  elif [ X"${DISTRO}" == X'FEDORA' ]; then
    sudo dnf -y install gcc-c++ make
    curl --silent --location https://rpm.nodesource.com/setup_6.x | sudo bash -
    sudo dnf -y install nodejs
  else
    echo "Cannot install Hack font automatically on this system. Please see https://github.com/chrissimpkins/Hack/blob/master/docs/INSTALLATION.md#manual-installation-on-linux"
    exit 255
  fi
fi

# Replace npm with ied
sudo npm i -g ied
echo '
# Replace npm with ied
alias npm ied' >> $FISH_EXPORT

# Install bower
# See https://bower.io/
sudo npm -g install bower

# Install gulp
# See https://gulpjs.com/
sudo npm -g install gulp

# Install grunt
# See https://gruntjs.com
sudo npm -g install grunt

# Install Node-Sass
# See: https://sass-lang.com, https://github.com/sass/node-sass
sudo npm -g install node-sass

echo 'Done.'

