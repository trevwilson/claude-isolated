---
name: merge-worktree
description: Merge isolated worktree changes back to the source branch
user-invocable: true
---

# Merge Worktree

Run the merge-worktree helper script to merge this session's changes back to the source branch.

## Instructions

1. First, commit any pending changes with a descriptive message
2. Run the merge-worktree script:

```bash
./merge-worktree
```

3. If there are merge conflicts:
   - Resolve the conflicts in the affected files
   - Stage the resolved files: `git add -A`
   - Commit the merge: `git commit`
   - Run `./merge-worktree` again

4. Report the result to the user
