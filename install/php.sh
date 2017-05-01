#! /bin/bash

############################################################
# PHP installation & Config
# PHP 7
############################################################
# Requires: brew.sh, git.sh

echo "--------------------------------------
    Starting PHP installation
--------------------------------------"

if [ X"${KERNEL_NAME}" == X'DARWIN' ]; then
  brew install php70 php70-gmagick php70-mcrypt php70-intl php70-xdebug php70-opcache

elif [ X"${KERNEL_NAME}" == X'LINUX' ]; then
  if [ X"${DISTRO}" == X'UBUNTU' ]; then
    sudo apt-get install -y mysql-client libmysqlclient-dev php php-cli php-pear php-gd php-curl php-mysql php-mcrypt php-sqlite3 php-imap php-intl php-xdebug php-imagick php7.0-opcache

  elif [ X"${DISTRO}" == X'FEDORA' ]; then
    # As per https://gist.github.com/risyasin/92075324caa9a46bfd5c
    # As of time of writing, the only way to get php7
    # on Fedora/RHEL/CentOS is to compile it yourself

    ## php7 compile requirements
    sudo dnf install -y gcc bison automake autoconf
    sudo dnf install -y libxml2-devel
    sudo dnf install -y bzip2-libs bzip2-devel
    sudo dnf install -y libjpeg-turbo libjpeg-turbo-devel
    sudo dnf install -y freetype-devel libpng-devel
    sudo dnf install -y libcurl-devel
    sudo dnf install -y community-mysql-common community-mysql-devel community-mysql-libs

    ## fetch php7 source
    sudo mkdir -p /usr/src/php7
    cd /usr/src/php7
    sudo git clone https://github.com/php/php-src.git

    cd /usr/src/php7/php-src/

    ## prepare php7 sources
    sudo ./buildconf

    ## configure php7
    sudo ./configure --with-config-file-path=/etc/php7/ \
    --enable-mbstring \
    --enable-zip \
    --enable-bcmath \
    --enable-pcntl \
    --enable-ftp \
    --enable-exif \
    --enable-sysvmsg \
    --enable-sysvsem \
    --enable-sysvshm \
    --enable-wddx \
    --enable-soap \
    --enable-mysqlnd \
    --enable-mcrypt \
    --with-curl \
    --with-iconv \
    --with-gmp \
    --with-pspell \
    --with-gd \
    --with-jpeg-dir=/usr \
    --with-png-dir=/usr \
    --with-zlib-dir=/usr \
    --with-xpm-dir=/usr \
    --with-freetype-dir=/usr \
    --enable-gd-native-ttf \
    --enable-gd-jis-conv \
    --with-openssl \
    --with-pdo-mysql=/usr \
    --with-gettext=/usr \
    --with-zlib=/usr \
    --with-bz2=/usr \
    --with-recode=/usr \
    --with-mysqli=/usr/bin/mysql_config

    sudo make -j2
    sudo make install

    sudo mkdir -p /etc/php7
    sudo cp /usr/src/php7/php-src/php.ini-development /etc/php7/.
  fi
fi

echo 'Done.'

