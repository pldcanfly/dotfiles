#!/usr/bin/env bash

# This script returns the current git branch and a status indicator if changes are detected.

# Check if the current directory is a git repository
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit

# Get the branch name
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

if [ "$branch" == "HEAD" ]; then
    echo "" # Not on a branch (e.g., detached HEAD)
else
    # Check for uncommitted changes
    if ! git diff-index --quiet HEAD --; then
        dirty_status="*"
    fi

    # Check for unpushed changes
    if [ "$(git log @{u}.. | wc -l)" -gt 0 ]; then
        unpushed_status="+"
    fi

    echo "$branch$dirty_status$unpushed_status"
fi
