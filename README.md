# claude-isolated

Spin up disposable git worktrees for Claude Code sessions. Each session gets its own temporary branch, so you can run multiple in parallel from the same source branch without conflicts. Changes stay isolated until you explicitly merge them.

## Installation

```bash
# User-local install (recommended)
./install.sh

# System-wide install
./install.sh --system
```

This installs:
- `claude-isolated` to `~/.local/bin/` (or `/usr/local/bin/` with `--system`)
- Bash completions for tab-completing branch names with `-b` and `-B`

## Usage

```bash
# Run in worktree based on current branch
claude-isolated

# Run in worktree based on a specific branch
claude-isolated -b main

# Create a new branch if it doesn't exist (branches from HEAD)
claude-isolated -B new-feature

# Add a custom name to identify the session
claude-isolated -n "refactor-api"
claude-isolated -b main -n "fix-auth-bug"

# Pass arguments through to claude
claude-isolated --resume
claude-isolated -B new-feature -n "initial-impl" --resume

# VS Code integration: open worktree in VS Code instead of launching Claude
claude-isolated --code                # Opens VS Code, you run claude manually
claude-isolated --code-wait           # Opens VS Code, merge prompts when closed
```

## How It Works

1. Creates a new branch `claude-session/<branch>[-<name>]-<YYYYMMDD-HHMM>` from your current (or specified) branch
2. Sets up a worktree in `.worktrees/<branch>[-<name>]-<YYYYMMDD-HHMM>`
3. Launches Claude Code in that worktree
4. After the session, prompts to merge changes back and clean up

Example worktree names:
- `main-20251229-1423` (from main branch)
- `feature-auth-20251229-1423` (from feature/auth branch)
- `main-refactor-api-20251229-1423` (with custom name)

Inside the session, you can run `./merge-worktree` to merge changes back to the source branch at any time.

## Why Use This?

- **Safety**: Claude's changes are isolated until you review and merge them
- **Clean diffs**: Easy to see exactly what Claude changed
- **Parallel work**: Keep working in your main directory while Claude works in isolation
- **Easy rollback**: Don't like the changes? Just decline to merge and clean up
