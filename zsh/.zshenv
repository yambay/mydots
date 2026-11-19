# Read by every zsh (also non-interactive); keep it limited to environment variables.
# Ubuntu's /etc/zsh/zshrc would run compinit itself; completion.zsh does it (once, cached).
skip_global_compinit=1
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
