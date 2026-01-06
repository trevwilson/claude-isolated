#!/usr/bin/bash
# Uninstall claude-isolated and related files

set -e

echo "Removing claude-isolated..."

# Try both user-local and system-wide locations
removed=0

# User-local binary
if [[ -f "${HOME}/.local/bin/claude-isolated" ]]; then
    rm "${HOME}/.local/bin/claude-isolated"
    echo "Removed ~/.local/bin/claude-isolated"
    removed=1
fi

# System-wide binary
if [[ -f "/usr/local/bin/claude-isolated" ]]; then
    sudo rm "/usr/local/bin/claude-isolated"
    echo "Removed /usr/local/bin/claude-isolated"
    removed=1
fi

# User-local completion
if [[ -f "${HOME}/.local/share/bash-completion/completions/claude-isolated" ]]; then
    rm "${HOME}/.local/share/bash-completion/completions/claude-isolated"
    echo "Removed ~/.local/share/bash-completion/completions/claude-isolated"
fi

# System-wide completion
if [[ -f "/etc/bash_completion.d/claude-isolated" ]]; then
    sudo rm "/etc/bash_completion.d/claude-isolated"
    echo "Removed /etc/bash_completion.d/claude-isolated"
fi

# Claude slash command
if [[ -f "${HOME}/.claude/commands/merge-worktree.md" ]]; then
    rm "${HOME}/.claude/commands/merge-worktree.md"
    echo "Removed ~/.claude/commands/merge-worktree.md"
fi

if [[ $removed -eq 0 ]]; then
    echo "claude-isolated was not found in standard locations"
fi

echo ""
echo "Done! You may also want to run 'claude-isolated --prune' before uninstalling"
echo "to clean up worktree entries from ~/.claude.json"
