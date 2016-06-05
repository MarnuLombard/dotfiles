#! /bin/bash

############################################################
# Inpired by so many great dotfiles out there.
# See: https://github.com/driesvints/dotfiles/blob/master/Brewfile
############################################################
# Requires: null
echo "--------------------------------------
    Starting Homebrew installation
--------------------------------------"


# Install Homebrew
# See: http://brew.sh/
$(which ruby) -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Get some homebrew packages
brew tap 'caskroom/cask'
brew tap 'caskroom/fonts'
brew tap 'caskroom/versions'
brew tap 'homebrew/bundle'
brew tap 'homebrew/dupes'
brew tap 'homebrew/php'

# Replace some default OSX CLIs, they're all outdated
brew install coreutils --with-default-names
brew install findutils --with-default-names
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
brew install bash

# Some usefull system level stuff
brew install imagemagick --with-webp
brew install lynx
brew install git

# Remove outdated versions from the cellar.
brew cleanup

echo "
  # Homebrew cask env var
  set HOMEBREW_CASK_OPTS '--appdir=/Applications'
  # Add path for homebrew 'coreutils'
  set PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
  # Add man path for homebre 'coreutils'
  set MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
" >> $FISH_EXPORT

echo "Done."
