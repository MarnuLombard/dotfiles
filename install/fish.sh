#! /bin/bash

############################################################
# Fish shell set up, includes, oh-my-fish, themes & plugins
# See: https://fishshell.com
############################################################
# Requires: dotfiles.sh, brew.sh

echo "--------------------------------------
    Starting Fish Shell installation
--------------------------------------"

if [ X"${DISTRO}" == X'DARWIN' ]; then
  brew install fish

elif [ X"${DISTRO}" == X'UBUNTU' ]; then
  sudo apt-add-repository ppa:fish-shell/release-2
  sudo apt-get update
  sudo apt-get install -y fish

elif [ X"${DISTRO}" == X'FEDORA' ]; then
  # Simple trick to parse OS version details
  # See: https://github.com/ValveSoftware/steam-for-linux/issues/2005#issuecomment-14521331
  . /etc/os-release

  curl "http://download.opensuse.org/repositories/shells:fish:release:2/Fedora_$VERSION_ID/shells:fish:release:2.repo" -o /etc/yum.repos.d/fish.repo
  sudo dnf install -y fish

fi


# Install Oh My Fish
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish

# OMF theme
omf install bobthefish
omf theme bobthefish

# Pull in the  ~/.fish_prompt file to fish config
echo'
# Import local custom exports file
if [ -f ~/.fish_exports ]
  set fish_function_path $fish_function_path ~/.fish_exports
end' >> ~/.config/omf/before.init.fish

echo 'Done.'
