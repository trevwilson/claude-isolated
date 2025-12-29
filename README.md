# claude-isolated

Run Claude Code in an isolated git worktree so changes don't affect your main working directory until you explicitly merge them.

## Installation

```bash
sudo cp claude-isolated /usr/local/bin/
sudo chmod +x /usr/local/bin/claude-isolated
```

## Usage

```bash
# Run in worktree based on current branch
claude-isolated

# Run in worktree based on a specific branch
claude-isolated -b main

# Add a custom name to identify the session
claude-isolated -n "refactor-api"
claude-isolated -b main -n "fix-auth-bug"

# Pass arguments through to claude
claude-isolated --resume
claude-isolated -b main -n "my-feature" --resume
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
