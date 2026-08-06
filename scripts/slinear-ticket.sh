#!/usr/bin/env bash
set -euo pipefail

# ── Dependency checks ──────────────────────────────────────────────
for cmd in linear claude git code; do
  command -v "$cmd" &>/dev/null || { echo "Error: '$cmd' not found in PATH"; exit 1; }
done

# ── Argument check ─────────────────────────────────────────────────
if [[ $# -ne 1 ]]; then
  echo "Usage: slinear-ticket <TICKET-ID or LINEAR-URL>"
  exit 1
fi

INPUT="$1"
REPO_ROOT="$(git rev-parse --show-toplevel)"

# ── Extract ticket ID from URL if needed ───────────────────────────
if [[ "$INPUT" =~ ^https?:// ]]; then
  TICKET_ID="$(echo "$INPUT" | grep -oE '[A-Z]+-[0-9]+' | head -1)" || true
  if [[ -z "$TICKET_ID" ]]; then
    echo "Error: could not extract ticket ID from URL: $INPUT"
    exit 1
  fi
else
  TICKET_ID="$INPUT"
fi

# ── Fetch ticket & generate branch name ────────────────────────────
echo "Fetching ticket $TICKET_ID..."
TICKET_JSON="$(linear issue view "$TICKET_ID" --json)" || {
  echo "Error: failed to fetch ticket $TICKET_ID"
  exit 1
}

BRANCH_NAME="$(echo "$TICKET_JSON" | claude -p --model claude-haiku-4-5-20251001 \
  "Generate a git branch name from this Linear ticket JSON. Format: ${TICKET_ID}-short-description (lowercase hyphenated description derived from the title, 3-5 words max). The prefix '${TICKET_ID}' must be kept exactly as provided (uppercased). Output ONLY the branch name, nothing else."
)" || {
  echo "Error: failed to generate branch name"
  exit 1
}

# Trim whitespace
BRANCH_NAME="$(echo "$BRANCH_NAME" | tr -d '[:space:]' | head -1)"
echo "Branch name: $BRANCH_NAME"

# ── Check for existing branches ────────────────────────────────────
EXISTING_LOCAL="$(git branch --list -i "*${TICKET_ID}*" 2>/dev/null | sed 's/^[*+ ]*//' | head -1)"
EXISTING_REMOTE="$(git branch -r --list -i "*${TICKET_ID}*" 2>/dev/null | sed 's/^[*+ ]*//' | sed 's|^origin/||' | head -1)"
EXISTING="${EXISTING_LOCAL:-$EXISTING_REMOTE}"

if [[ -n "$EXISTING" ]]; then
  echo ""
  echo "A branch matching '$TICKET_ID' already exists: $EXISTING"
  echo "  [1] Create a new worktree and check out the existing branch"
  echo "  [2] Create a new branch anyway (will auto-suffix if needed)"
  echo "  [3] Remove existing worktree & branch, start fresh"
  echo "  [4] Abort"
  read -rp "Choose [1/2/3/4]: " choice

  case "$choice" in
    1)
      BRANCH_NAME="$EXISTING"
      # Make sure the branch exists locally
      if ! git show-ref --verify --quiet "refs/heads/$EXISTING"; then
        git fetch origin "$EXISTING" 2>/dev/null || true
        git branch "$EXISTING" "origin/$EXISTING" 2>/dev/null || true
      fi
      ;;
    2)
      # Auto-suffix if the generated name already exists
      if git show-ref --verify --quiet "refs/heads/$BRANCH_NAME" 2>/dev/null || \
         git show-ref --verify --quiet "refs/remotes/origin/$BRANCH_NAME" 2>/dev/null; then
        SUFFIX=2
        while git show-ref --verify --quiet "refs/heads/${BRANCH_NAME}-${SUFFIX}" 2>/dev/null || \
              git show-ref --verify --quiet "refs/remotes/origin/${BRANCH_NAME}-${SUFFIX}" 2>/dev/null; do
          ((SUFFIX++))
        done
        BRANCH_NAME="${BRANCH_NAME}-${SUFFIX}"
        echo "Using suffixed branch name: $BRANCH_NAME"
      fi
      ;;
    3)
      # Remove existing worktree if it exists
      EXISTING_WT="$REPO_ROOT/.claude/worktrees/$EXISTING"
      if [[ -d "$EXISTING_WT" ]]; then
        echo "Removing worktree at $EXISTING_WT..."
        git worktree remove --force "$EXISTING_WT"
      fi
      # Delete the local branch
      if git show-ref --verify --quiet "refs/heads/$EXISTING"; then
        echo "Deleting branch $EXISTING..."
        git branch -D "$EXISTING"
      fi
      # Use the newly generated branch name
      ;;
    4)
      echo "Aborted."
      exit 0
      ;;
    *)
      echo "Invalid choice. Aborted."
      exit 1
      ;;
  esac
fi

# ── Create worktree ────────────────────────────────────────────────
WORKTREE_DIR="$REPO_ROOT/.claude/worktrees/$BRANCH_NAME"

if [[ -d "$WORKTREE_DIR" ]]; then
  echo "Worktree directory already exists: $WORKTREE_DIR"
  echo "Opening existing worktree..."
  code "$WORKTREE_DIR"
  exit 0
fi

mkdir -p "$REPO_ROOT/.claude/worktrees"

if [[ "${choice:-}" == "1" ]]; then
  # Check out existing branch into new worktree
  git worktree add "$WORKTREE_DIR" "$BRANCH_NAME"
else
  # Create new branch off main
  BASE_BRANCH="main"
  if ! git show-ref --verify --quiet "refs/heads/$BASE_BRANCH"; then
    BASE_BRANCH="master"
  fi
  git worktree add -b "$BRANCH_NAME" "$WORKTREE_DIR" "$BASE_BRANCH"
fi

echo "Worktree created at: $WORKTREE_DIR"
code "$WORKTREE_DIR"
