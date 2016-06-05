#! /bin/bash

############################################################
# This is the bootstrap file.
# See the ./* files for more details on sources
############################################################


echo "OKAY LET'S START THIS..."

# As per: ~/.osx — https://mths.be/osx
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until scripts have finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Export var containing name of current distro
# We will now have $KERNEL_NAME & $DISTRO
# Source: https://bitbucket.org/zhb/iredmail/src/cfbb33763194e0235f82375ff70bba39b5ca998c/iRedMail/conf/global
. ./distro.sh

# Let's create an exports file, that though it's not directly loaded,
# Will be symlinked to a file that's autoloaded by fish or a plugin
export FISH_EXPORT="$HOME/.fish_export"
touch $FISH_EXPORT


# Run the scripts
sh "./install/dotfiles.sh"

# Only run this on Mac OSX
if [ $HOST = "OSX" ]; then
  sh "./install/brew.sh"
  sh "./install/osx.sh"
fi

sh "./install/exports.sh"
sh "./install/fish.sh"
sh "./install/php.sh"
sh "./install/composer.sh"
sh "./install/vim.sh"
sh "./install/git.sh"
sh "./install/node.sh"
sh "./install/fonts.sh"
