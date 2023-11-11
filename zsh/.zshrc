# Set up the prompt

# Sources:
# 0. https://thevaluable.dev/zsh-install-configure-mouseless
# 1. https://ianyepan.github.io/posts/moving-away-from-ohmyzsh/
# 2. https://dev.to/rossijonas/how-to-set-up-history-based-autocompletion-in-zsh-k7o

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_SETTINGS=$HOME/mydots/zsh

export EDITOR="nvim"
export VISUAL="nvim"

setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
unsetopt HIST_SAVE_NO_DUPS       # Write a duplicate event to the history file

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
bindkey "\e[3~" delete-char

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


# Bind aliases
source $ZSH_SETTINGS/aliases.zsh

source $ZSH_SETTINGS/completion.zsh

# Add Git information to the prompt (and activate prompt config)
source $ZSH_SETTINGS/vcs_info.zsh
