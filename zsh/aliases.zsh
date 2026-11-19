# Set up useful aliases

# Brew aliases (wherever Homebrew is installed: macOS, Linuxbrew)
if (( $+commands[brew] )); then
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
alias gst='git status'
alias gsw='git switch'

# standard unix commands
alias ..='cd ..'
if ls --color=auto / >/dev/null 2>&1; then
	alias l='ls -lah --color=auto'	# GNU ls (Linux)
else
	alias l='ls -lahG'	# BSD ls (macOS)
fi
alias h='history 1'
alias df='df -H'
alias du='du -ch'
alias c='clear'

# Docker commands
alias d='docker'
alias dr='docker run'
alias di='docker image'
alias dp='docker ps'

# Podman commands
alias p="podman"

# Kubernetes commands
alias k='kubectl'

# IntelliJ IDEA
if [[ -x /opt/intellij/bin/idea.sh ]]; then
	alias idea='/opt/intellij/bin/idea.sh > /dev/null 2>&1 &'
fi

# add Debian/Ubuntu specific aliases
if command -v apt-get > /dev/null; then
	# apt commands
	alias aud='sudo apt update'
	alias aug='sudo apt upgrade'
	alias aul='apt list --upgradable'
	alias aar='sudo apt autoremove'
	alias ai='sudo apt install'
	alias as='apt search'
fi
