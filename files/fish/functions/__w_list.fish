function __w_list
    # Print all worktree paths for the current repo (one per line), plus
    # any dirs in ./.claude/worktrees that aren't registered git worktrees.
    set -l paths

    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        for line in (git worktree list --porcelain 2>/dev/null)
            if string match -q 'worktree *' -- $line
                set -a paths (string sub -s 10 -- $line)
            end
        end
    end

    set -l claude_dir
    if test -d ./.claude/worktrees
        set claude_dir (realpath ./.claude/worktrees)
    else
        set -l parent (dirname (pwd))
        if string match -q '*/.claude/worktrees' -- $parent
            set claude_dir (realpath $parent)
        end
    end

    if test -n "$claude_dir"
        for d in (find $claude_dir -maxdepth 1 -mindepth 1 -type d 2>/dev/null | sort)
            set -a paths $d
        end
    end

    printf '%s\n' $paths | awk '!seen[$0]++'
end
