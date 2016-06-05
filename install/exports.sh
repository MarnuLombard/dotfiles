#! /bin/bash

############################################################
# Set up the global variables, distro dependant
############################################################
# Requires: distro.sh, fish.sh

if [ X"${KERNEL_NAME}" == X'DARWIN' ]; then
echo "--------------------------------------
    Starting OSX exports
--------------------------------------"

echo '' >> $FISH_EXPORT

elif [ X"${KERNEL_NAME}" == X'LINUX' ]; then

echo "--------------------------------------
    Starting Linux exports
--------------------------------------"

echo '
  # For BumbleBee on Linux
  setenv LD_LIBRARY_PATH /usr/lib64/nvidia-bumblebee:/usr/lib/nvidia-bumblebee:/usr/lib64:/usr/lib:/usr/lib64/VirtualGL

  # For Wine/IE8/Skype on Linux
  export WINEARCH=win32

  # A hack around using the same configs for user & root
  set USER (whoami)
' >> $FISH_EXPORT
else
  # Not support *BSD and other distrobutions yet.
  echo "Error: Your OS is not supported yet."
  exit 255
fi

echo "Done."
