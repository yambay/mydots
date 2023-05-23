# Git status settings
# Examples/Docs: 
# -> https://salferrarello.com/zsh-git-status-prompt/
# -> https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information

autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' %F{red}*'
zstyle ':vcs_info:*' stagedstr ' %F{green}+'

zstyle ':vcs_info:git:*' formats       '[%b%u%c%F{#1b7ced}]'
zstyle ':vcs_info:git:*' actionformats '[%b|%a%u%c%F{#1b7ced}]'


PROMPT='%F{green}%~%u %F{#1b7ced}${vcs_info_msg_0_} %(?.%F{#1b7ced}.%F{red})%(!.#.➜)%f '

