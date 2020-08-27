#!/bin/bash

# git
alias g='git'

# ruby/dev
alias be='bundle exec'
alias ber='bundle exec rails'
alias bers='bundle exec rspec'
alias cdh='cd ~/Code/heroku'
alias cdg='cd $GOPATH/src/github.com/tbalthazar'
alias cop='bundle exec rake coal_car:rubocop'
alias h='heroku'
alias rctags='ctags -f tags.ctags -R --languages=ruby --exclude=.git --exclude=log .'
alias rib='h run:inside web.1 bash -a'

# others
alias fixcamera='sudo killall VDCAssistant'
alias hosts="sudo vim /etc/hosts"
alias ls='ls -lh'
alias meteo='curl wttr.in'
alias nsaudit='sudo netstat -plunt'
alias ping='ping -c4'
alias til='cd ~/Code/others/til && vim'
alias upgradesystem='sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove'
alias k='kubectl'
alias d='docker'
alias dc='docker-compose'
alias mp='multipass'
alias mk='microk8s kubectl'
