function w
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
    for d in $dirs
        set -l rel (string replace -- "$base/" '' $d)
        if test "$rel" = "$base"
            set rel .
        end
        set -a display $rel
    end

    set -l selected (printf '%s\n' $display | fzf --prompt="worktree> " --height=40% --reverse --no-sort --query="$argv[1]")
    if test -n "$selected"
        if test "$selected" = .
            cd $base
        else if string match -q '/*' -- $selected
            cd $selected
        else
            cd $base/$selected
        end
    end
end
