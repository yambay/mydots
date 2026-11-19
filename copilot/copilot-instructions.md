# Personal instructions for GitHub Copilot CLI

These instructions apply to all repositories.

## Working directory

- Work only inside the current Git repository (its root and all subdirectories). Outside of a Git repository, work only inside the current working directory and its subdirectories. This applies to reading, writing and running commands.
- This rule is about explicit access: file operations and commands that target paths outside of this scope. Files that tools access on their own are fine (e.g. `~/.gitconfig`, package manager and build caches).
- The Copilot session folder (`~/.copilot/session-state/<session-id>/`, or under `$COPILOT_HOME`) may be used.
- Avoid any other access outside of this scope (e.g. `$HOME`, `/tmp`, other repositories). If it is unavoidable, ask me for confirmation first and explain why.

## Git

- Never add a `Co-authored-by` trailer or any other trailer that credits Copilot or an AI to commit messages. Other trailers such as `Signed-off-by` are fine.
