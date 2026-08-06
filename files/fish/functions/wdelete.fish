function wdelete
    set -l dirs (__w_list)
    if test (count $dirs) -eq 0
        echo "No worktrees found."
        return 1
    end

    set -l main (git worktree list --porcelain 2>/dev/null | awk '/^worktree / {print substr($0,10); exit}')
    set -l base $main
    if test -z "$base"
        set base (pwd)
    end

    set -l display
    set -l paths
    for d in $dirs
        if test -n "$main" -a "$d" = "$main"
            continue
        end
        set -l rel (string replace -- "$base/" '' $d)
        set -a display $rel
        set -a paths $d
    end

    if test (count $display) -eq 0
        echo "No deletable worktrees (root excluded)."
        return 1
    end

    set -l selected (printf '%s\n' $display | fzf --multi --prompt="delete (tab to mark)> " --height=40% --reverse --no-sort --query="$argv[1]")
    if test (count $selected) -eq 0
        return
    end

    # Map selected display lines back to absolute paths.
    set -l to_delete
    for s in $selected
        for i in (seq (count $display))
            if test "$display[$i]" = "$s"
                set -a to_delete $paths[$i]
                break
            end
        end
    end

    echo "About to delete:"
    for s in $to_delete
        echo "  $s"
    end
    read -P "Confirm? [y/N] " -l answer
    if test "$answer" != y -a "$answer" != Y
        echo "Aborted."
        return
    end

    for s in $to_delete
        if not git worktree remove --force $s 2>/dev/null
            rm -rf $s
        end
        echo "Deleted: $s"
    end
end
