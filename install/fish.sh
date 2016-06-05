#! /bin/bash

############################################################
# Fish shell set up, includes, oh-my-fish, themes & plugins
# See: https://fishshell.com
############################################################
# Requires: dotfiles.sh, brew.sh

echo "--------------------------------------
    Starting Fish Shell installation
--------------------------------------"

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
