# Git status settings
# Examples/Docs: 
# -> https://salferrarello.com/zsh-git-status-prompt/
# -> https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information

autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' %F{red}*%f'
zstyle ':vcs_info:*' stagedstr ' %F{green}+%f'

zstyle ':vcs_info:git:*' formats       '[%b%u%c%F{blue}]%f'
zstyle ':vcs_info:git:*' actionformats '[%b|%a%u%c%F{blue}]%f'


PROMPT='%{$fg[green]%}%~%u %F{blue}${vcs_info_msg_0_}%f %(?.%{$fg[blue]%}.%{$fg[red]%})%(!.#.➜)%{$reset_color%} '

