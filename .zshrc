# Set up the prompt

# Sources:
# 1. https://ianyepan.github.io/posts/moving-away-from-ohmyzsh/
# 2. https://dev.to/rossijonas/how-to-set-up-history-based-autocompletion-in-zsh-k7o

export ZSH_SETTINGS=$HOME/mydots

# Turn off all beeps
unsetopt BEEP
# Turn off autocomplete beeps
unsetopt LIST_BEEP

autoload -Uz promptinit 
promptinit
setopt PROMPT_SUBST
autoload -U colors && colors
export PS1="%d/ > "

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Define bindigs for "pos1/home" and "end" buttons
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history
# No duplicate history when reverse-searching my commands
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# git aliases
alias g='git'
alias ga='git add .'
alias gc='git commit -m '
alias gl='git log'
alias gs='git status'
alias gps='git push'
alias gpl='git pull'

# standard linux commands
alias ..='cd ..'
alias l='ls -lah --color=auto'
alias ll='l'
alias h='history'
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

# apt commands
alias aud='sudo apt update'
alias aug='sudo apt upgrade'
alias aul='apt list --upgradable'

source $ZSH_SETTINGS/completion.zsh
source $ZSH_SETTINGS/git.zsh

