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

# Pass arguments through to claude
claude-isolated --resume
claude-isolated -b main --resume
```

## How It Works

1. Creates a new branch `claude-session/<timestamp>` from your current (or specified) branch
2. Sets up a worktree in `.worktrees/<timestamp>`
3. Launches Claude Code in that worktree
4. After the session, prompts to merge changes back and clean up

Inside the session, you can run `./merge-worktree` to merge changes back to the source branch at any time.

## Why Use This?

- **Safety**: Claude's changes are isolated until you review and merge them
- **Clean diffs**: Easy to see exactly what Claude changed
- **Parallel work**: Keep working in your main directory while Claude works in isolation
- **Easy rollback**: Don't like the changes? Just decline to merge and clean up
