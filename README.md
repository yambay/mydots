# mydots

Personal dotfiles for zsh and vim. Works on macOS and Ubuntu.

## Requirements

- Required: `zsh` and `git` (the prompt and the Git aliases use it).
- Recommended: the full `vim` (on Ubuntu not just `vim-tiny`).
  Without `vim`, `EDITOR` falls back to `vi` and the `.vimrc` is skipped.
- Optional:
  - [Homebrew](https://brew.sh) (macOS or Linuxbrew): detected via `brew`; sets up `PATH`, completions and the `b*` aliases.
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
    (`brew install zsh-autosuggestions` or `sudo apt install zsh-autosuggestions`).
    It is loaded automatically if found, and Shift+Tab accepts a suggestion.
  - Tools whose completions are generated: kubectl, rustup, kind, crc, oc, podman, ng, colima.

Ubuntu:

```sh
sudo apt install zsh vim git zsh-autosuggestions
```

## Installation

```sh
git clone git@github.com:yambay/mydots.git ~/mydots
~/mydots/install.sh
chsh -s "$(command -v zsh)"   # Ubuntu starts bash by default; log out and in afterwards
```

The script symlinks `~/.vimrc`, `~/.zshenv` and `~/.zshrc` to this repository. Existing files, and symlinks pointing elsewhere, are backed up as `*.bak.<timestamp>`. Running it again is safe. It prints a hint if your login shell is not zsh.

## Structure

| File | Purpose |
|------|---------|
| `.vimrc` | Vim configuration |
| `zsh/.zshenv` | XDG base directory variables (all shells) |
| `zsh/.zshrc` | Entry point, environment, history |
| `zsh/aliases.zsh` | Aliases (macOS/Ubuntu specific ones are set per OS) |
| `zsh/completion.zsh` | Completion settings and generated completions |
| `zsh/vcs_info.zsh` | Prompt with Git status (`*` modified, `+` staged, `?` untracked; `vcs-status-toggle` switches the checks off in large repos) |

## Local settings

Machine-specific settings go into `~/.zshrc.local` (not versioned, sourced at the end of `.zshrc`). Installers that append to `~/.zshrc` (nvm, sdkman, `ng` autocompletion, ...) write through the symlink into this repository; move such lines into `~/.zshrc.local`.

## Completions

Completion files for installed tools (kubectl, rustup, cargo, kind, crc, oc, podman, ng, colima) are generated into `~/.config/zsh/completions` on the first shell start, only if the tool is installed and the file does not exist yet. To regenerate them (e.g. after a tool update), run:

```zsh
update-completions
```

## Platform notes

- Wherever Homebrew is installed (macOS, Linuxbrew): `brew shellenv`, Homebrew aliases (`b`, `bud`, `bug`, `bo`), completion paths and the Java path.
- macOS: BSD `ls` colors and `ps` options.
- Ubuntu: apt aliases (`aud`, `aug`, `aul`, `aar`, `ai`, `as`), GNU `ls` colors.
- Java, Colima and IntelliJ settings are only applied if they are installed.
