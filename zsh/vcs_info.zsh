# Git status settings
# Examples/Docs:
# -> https://salferrarello.com/zsh-git-status-prompt/
# -> https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information

# Map the truecolor prompt colors to the nearest color, but only on terminals without truecolor
[[ $COLORTERM == *(24bit|truecolor)* ]] || zmodload zsh/nearcolor 2>/dev/null

autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info

# Only Git is checked
zstyle ':vcs_info:*' enable git

# Detecting changes can be slow in large repos. Toggle it per shell with: vcs-status-toggle
typeset -g VCS_STATUS_CHECK=true
vcs-status-toggle() {
    [[ $VCS_STATUS_CHECK == true ]] && VCS_STATUS_CHECK=false || VCS_STATUS_CHECK=true
    echo "Git status markers in prompt: $VCS_STATUS_CHECK"
}
zstyle -e ':vcs_info:git:*' check-for-changes 'reply=($VCS_STATUS_CHECK)'
zstyle ':vcs_info:*' unstagedstr ' %F{red}*'
zstyle ':vcs_info:*' stagedstr ' %F{green}+'

# Marker for untracked files, appended after the staged marker
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
    [[ $VCS_STATUS_CHECK == true ]] || return 0
    if [[ -n $(git ls-files --others --exclude-standard --directory -- ':/' 2>/dev/null | head -n 1) ]]; then
        hook_com[staged]+=' %F{yellow}?'
    fi
}

zstyle ':vcs_info:git:*' formats       '[%b%u%c%F{#1b7ced}]'
zstyle ':vcs_info:git:*' actionformats '[%b|%a%u%c%F{#1b7ced}]'

PROMPT='%F{green}%~%f%F{#1b7ced}${vcs_info_msg_0_:+ $vcs_info_msg_0_}%f %(?.%F{#1b7ced}.%F{red})%(!.#.➜)%f '
