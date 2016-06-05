#! /bin/bash

############################################################
# Inpired by so many great dotfiles out there.
# See: https://github.com/driesvints/dotfiles/blob/master/Brewfile
############################################################
# Requires: distro.sh, brew.sh

echo "--------------------------------------
    Starting Docker installation
--------------------------------------"

if [ X"${KERNEL_NAME}" == X'DARWIN' ]; then
  # Several scripts use 'default' when looking for a docker-machine
  export DOCKER_MACHINE_NAME='default'

  # Install docker-toolbox
  brew cask install dockertoolbox

  # Install VirtualBox
  brew cask install virtualbox virtualbox-extension-pack

  # create the machine
  docker-machine create --driver "virtualbox" $DOCKER_MACHINE_NAME

  # start the docker machine
  docker-machine start $DOCKER_MACHINE_NAME

  # this command allows the docker commands to be used in the terminal
  eval "$(docker-machine env $DOCKER_MACHINE_NAME)"

  # Add docker-machine env loading to fish exports
  echo "
  # Load Docker env vars
  eval (docker-machine env $DOCKER_MACHINE_NAME)
  " >> $FISH_EXPORT

elif [ X"${KERNEL_NAME}" == X'LINUX' ]; then
  if [ X"${DISTRO}" == X'UBUNTU' ]; then
    # Install VirtualBox
    sudo apt-get install -y dkms
    sudo apt-get install -y virtualbox virtualbox-guest-dkms virtualbox-ext-pack

    # Start VirtualBox
    VirtualBox

    # Install Docker
    curl -fsSL https://get.docker.com/ | sudo sh -

    # Start Docker
    sudo service docker start

  elif [ X"${DISTRO}" == X'FEDORA' ]; then
    # Adapted from source: http://www.if-not-true-then-false.com/2010/install-virtualbox-with-yum-on-fedora-centos-red-hat-rhel/

    # Add Virtualbox dnf/yum repo
    sudo curl http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo -o /etc/yum.repos.d/virtualbox.repo

    # Install VirtualBox
    sudo dnf install -y binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms
    # This command create automatically vboxusers group and VirtualBox user must be member of that group.
    sudo dnf install -y VirtualBox-5.0 # VirtualBox 5.0.20 is currenly newest

    # Rebuild kernel modules
    sudo service vboxdrv setup

    # Add user to vboxusers group
    sudo usermod -a -G vboxusers $(whoami)

    # Start VirtualBox
    VirtualBox

    # Add Docker dnf/yum repo
    sudo echo /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/fedora/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
    # Install Docker
    sudo dnf install -y docker-engine

    # Start docker
    sudo systemctl start docker

  else
    echo "Cannot install Docker automatically on this system."
    exit 255
  fi

  # Create the docker group
  sudo groupadd docker
  # Add current user to the docker group
  sudo usermod -aG docker $(whoami)

fi



echo "--------------------------------------
    Installing Docker images
--------------------------------------"

# add ubuntu/php7 personal dockerfile
# Pull file
# Build docker image
# tag image/container

echo "Done."
