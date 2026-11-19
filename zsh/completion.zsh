# Settings for autocompletion

COMPLETIONS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/completions"
ZCOMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/.zcompdump"
mkdir -p "$COMPLETIONS_DIR"
fpath=("$COMPLETIONS_DIR" $fpath)

# Generate completion files only if missing. Regenerate all with: update-completions
_gen_completion() {  # usage: _gen_completion <command> <file> <args...>
    local cmd=$1 file="$COMPLETIONS_DIR/$2"; shift 2
    (( $+commands[$cmd] )) || return 0
    # Homebrew/apt ship their own completions that stay up to date: they win over generated ones
    local -a other=( ${^fpath:#$COMPLETIONS_DIR}/${file:t}(N) )
    if (( $#other )); then
        rm -f "$file"
        return 0
    fi
    [[ -s $file ]] && return 0
    # SHELL=zsh: some tools (ng) pick the script flavor from $SHELL, which may be bash
    if SHELL=zsh "$cmd" "$@" > "$file" 2>/dev/null </dev/null && [[ -s $file ]]; then
        _completions_generated=1
    else
        rm -f "$file"
    fi
}

_gen_all_completions() {
    _gen_completion kubectl _kubectl completion zsh
    _gen_completion rustup  _rustup  completions zsh
    _gen_completion rustup  _cargo   completions zsh cargo
    _gen_completion kind    _kind    completion zsh
    _gen_completion crc     _crc     completion zsh
    _gen_completion oc      _oc      completion zsh
    _gen_completion podman  _podman  completion zsh
    _gen_completion ng      _ng      completion script
    _gen_completion colima  _colima  completion zsh
}

update-completions() {
    rm -f "$COMPLETIONS_DIR"/_*(N)
    _gen_all_completions
    rm -f "$ZCOMPDUMP"
    compinit -d "$ZCOMPDUMP"
}

# Use modern completion system (full check once a day, cached dump otherwise)
autoload -Uz compinit
_completions_generated=0
_gen_all_completions
mkdir -p "${ZCOMPDUMP:h}"
() {
    setopt localoptions extendedglob
    local -a stale
    stale=( $ZCOMPDUMP(#qN.mh+24) )  # non-empty if the dump is older than 24h
    if (( _completions_generated )) || (( ${#stale} )) || [[ ! -f $ZCOMPDUMP ]]; then
        rm -f "$ZCOMPDUMP"  # compinit would otherwise trust a stale dump with the same file count
        compinit -d "$ZCOMPDUMP"
    else
        compinit -C -d "$ZCOMPDUMP"
    fi
}
unset _completions_generated

# The generated _ng has a stray quote in its loadautofunc check, so the first TAB in a
# new shell would complete nothing. Sourcing it once registers the completion directly.
[[ -r $COMPLETIONS_DIR/_ng ]] && source "$COMPLETIONS_DIR/_ng"

# Autosuggestions (optional plugin: Homebrew, or apt on Ubuntu)
for plugin in ${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh} \
              /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh; do
    [[ -r $plugin ]] && { source $plugin; break; }
done
(( $+widgets[autosuggest-accept] )) && bindkey '^[[Z' autosuggest-accept  # shift + tab

# search history by the whole typed prefix using arrow keys
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
for key in '\e[A' "${terminfo[kcuu1]}"; do [[ -n $key ]] && bindkey "$key" up-line-or-beginning-search; done
for key in '\e[B' "${terminfo[kcud1]}"; do [[ -n $key ]] && bindkey "$key" down-line-or-beginning-search; done

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
if whence dircolors >/dev/null; then
  eval "$(dircolors -b)"
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
else
  export CLICOLOR=1
  zstyle ':completion:*:default' list-colors ''
fi
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# BSD ps (macOS) uses "command", procps (Linux) uses "cmd"
if [[ $OSTYPE == darwin* ]]; then
  zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,command'
else
  zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
fi
