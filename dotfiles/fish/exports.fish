###############
## EXPORTS
###############

set PATH /usr/local/bin $HOME/.composer/vendor/bin /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

set LC_CTYPE en_US.UTF-8
set LANG en_US.UTF-8

### Fish
# Only show the current directory's name in the tab
set PROMPT_COMMAND 'echo -ne "\033]0;${PWD##*/}\007"'

## BobTheFish theme
set -g theme_display_vi no
set -g theme_nerd_fonts yes
set -g default_user marnu
set -g theme_title_display_process yes


## For performance improvements, XDebug is disabled by default.
# this is a workaround to be able to use it when needed
alias phpx="php -dzend_extension=xdebug.so -dxdebug.remote_enable=1 -dxdebug.remote_host=localhost -dxdebug.remote_port=9000 -dxdebug.remote_autostart=1 -dxdebug.remote_connect_back=1 -dxdebug.profiler_enable=1 -dxdebug.idekey=PHPSTORM -dxdebug.max_nesting_level=900"

#Homestead/Vagrant
alias vm="set CURRENTPATH (pwd); cd ~/vagrant; and vagrant ssh; and cd $CURRENTPATH"
alias vmup="set CURRENTPATH (pwd); cd ~/vagrant; and vagrant up; and cd $CURRENTPATH"
alias vmreload="set CURRENTPATH (pwd); cd ~/vagrant; and vagrant halt; and vagrant up --provision; and cd $CURRENTPATH"
alias vmdie="set CURRENTPATH (pwd); cd ~/vagrant; and vagrant halt; and cd $CURRENTPATH"

#Docker
alias dockerstop='docker stop (docker ps -a -q)'

#phpspec
alias phpspec="vendor/bin/phpspec"

#PhpUnit
alias phpunit='vendor/bin/phpunit'

# Node.js & npm
set NODE_PATH "/usr/lib/node_modules"

# Composer
alias cda="composer dumpautoload"

# CodeCeption
alias codecept="php bin/codecept"

# Laravel
alias artisan="php artisan"
alias tinker="php artisan tinker"

# Symfony
alias console="php app/console"

# Behat
alias behat="vendor/bin/behat"
alias begat="vendor/bin/behat"

#Git
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m '
alias gb='git branch'
alias gp='git push'

# vi:syntax=bash
