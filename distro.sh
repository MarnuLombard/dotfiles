#!/bin/bash

# Check distribution.
#   - DISTRO
#   - DISTRO_VERSION
#   - DISTRO_CODENAME
#
# Kernel name, in upper cases.
export KERNEL_NAME="$(uname -s | tr '[a-z]' '[A-Z]')"

# Detect Mac OSX
if [ X"${KERNEL_NAME}" == X'DARWIN' ]; then
  export DISTRO='OSX'

# Detect distro name and release version.
elif [ X"${KERNEL_NAME}" == X'LINUX' ]; then
    if [ -f /etc/fedora-release ]; then
        # Fedora
        export DISTRO='FEDORA'
    elif [ -f /etc/redhat-release ]; then
        # RHEL/CentOS
        export DISTRO='RHEL'
    elif [ -f /etc/lsb-release && grep -i 'DISTRIB_ID=Ubuntu' /etc/lsb-release &>/dev/null ]; then
        # Ubuntu
        export DISTRO='UBUNTU'
    elif [ -f /etc/debian_version ]; then
        # Debian
        export DISTRO='DEBIAN'
    fi

elif [ X"${KERNEL_NAME}" == X'FREEBSD' ]; then
    export DISTRO='FREEBSD'
elif [ X"${KERNEL_NAME}" == X'OPENBSD' ]; then
    export DISTRO='OPENBSD'
else
    # Not support *BSD and other distrobutions yet.
    echo "Error: Your OS is not supported yet."
    exit 255
fi
