# Sources:
# 0. https://thevaluable.dev/zsh-install-configure-mouseless
# 1. https://ianyepan.github.io/posts/moving-away-from-ohmyzsh/
# 2. https://dev.to/rossijonas/how-to-set-up-history-based-autocompletion-in-zsh-k7o

ZSH_SETTINGS=${${(%):-%x}:A:h}	# directory of this file (symlinks resolved)

# No duplicate entries in PATH/fpath when this file is sourced again
typeset -U path fpath

# Homebrew: PATH, MANPATH, fpath (completions) and HOMEBREW_* variables.
# Set up here and not in .zshenv, because path_helper reorders PATH after that on macOS.
for brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    [[ -x $brew ]] && { eval "$($brew shellenv)"; break }
done
unset brew

# User binaries (~/.profile is not read by zsh)
[[ -d $HOME/.local/bin ]] && path=($HOME/.local/bin $path)

# Java (Homebrew openjdk, if installed)
[[ -n $HOMEBREW_PREFIX && -d $HOMEBREW_PREFIX/opt/openjdk@25/bin ]] && path=($HOMEBREW_PREFIX/opt/openjdk@25/bin $path)

# Colima as Docker runtime (only if installed)
if (( $+commands[colima] )); then
    export DOCKER_HOST="unix://${HOME}/.config/colima/default/docker.sock"
    export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
fi

# Brew config
export HOMEBREW_NO_ENV_HINTS=1

if (( $+commands[vim] )); then
    export EDITOR="vim"
else
    export EDITOR="vi"  # only vim-tiny/vi installed
fi
export VISUAL="$EDITOR"

# Turn off all beeps
unsetopt BEEP
unsetopt LIST_BEEP

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Bindings for "pos1/home", "end" and "delete": common sequences plus the terminfo ones
# (tmux/screen send different sequences than most terminals)
for key in '^[[H' '^[[1~' "${terminfo[khome]}"; do [[ -n $key ]] && bindkey "$key" beginning-of-line; done
for key in '^[[F' '^[[4~' "${terminfo[kend]}"; do [[ -n $key ]] && bindkey "$key" end-of-line; done
for key in '^[[3~' "${terminfo[kdch1]}"; do [[ -n $key ]] && bindkey "$key" delete-char; done

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "${HISTFILE:h}"
# One-time migration from the old location
if [[ ! -e $HISTFILE && -f ~/.cache/.zsh_history ]]; then
    mv ~/.cache/.zsh_history "$HISTFILE"
fi
setopt sharehistory           # implies incremental append, shared between sessions
setopt extended_history       # store timestamps and durations
setopt hist_ignore_all_dups   # drop older duplicate entries
setopt hist_find_no_dups      # skip duplicates when searching
setopt hist_ignore_space      # do not store commands starting with a space
setopt hist_verify            # show history expansion (!!) before executing

source $ZSH_SETTINGS/aliases.zsh	# bind aliases
source $ZSH_SETTINGS/completion.zsh	# activate completion settings
source $ZSH_SETTINGS/vcs_info.zsh	# Add Git information to the prompt and activate prompt config

# Machine-specific settings and lines appended by installers (nvm, sdkman, ...); not versioned
if [[ -r ~/.zshrc.local ]]; then source ~/.zshrc.local; fi
