# Set up useful aliases

# add Mac specific aliases
if [[ $(uname) == "Darwin" ]]; then
	# Brew aliases
	alias b='brew'
	alias bud='brew update'
	alias bug='brew upgrade'
	alias bo='brew outdated -g'
fi

# git aliases
alias g='git'
alias ga='git add .'
alias gb='git branch'
alias gc='git commit -m '
alias gd='git diff'
alias gf='git fetch'
alias gl='git log'
alias gps='git push'
alias gpl='git pull'
alias grb='git rebase'
alias grs='git reset'
alias gs='git status'
alias gsw='git switch'

# standard unix commands
alias ..='cd ..'
alias l='ls -lah --color=auto'
alias ll='l'
alias h='history 1'
alias df='df -H'
alias du='du -ch'
alias c='clear'

# Docker commands
alias d='docker'
alias dr='docker run'
alias di='docker image'
alias dp='docker ps'

# Kubernetes commands
alias k='kubectl'

# add Debian/Ubuntu specific aliases
if command -v apt-get > /dev/null; then
	# apt commands
	alias aud='sudo apt update'
	alias aug='sudo apt upgrade'
	alias aul='apt list --upgradable'
fi
