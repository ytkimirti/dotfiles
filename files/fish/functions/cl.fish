function cl -d "resume the last claude session started in this terminal"
    set -l t (tty 2>/dev/null)
    if test -z "$t"; or string match -q "not a tty*" -- $t
        echo "cl: no tty" >&2
        return 1
    end
    set -l key (string replace -r '^/dev/' '' -- $t | string replace -a / -)
    set -l f "$HOME/.claude/last-session/$key"
    if not test -f $f
        echo "cl: no claude session recorded for $t yet (start one here first)" >&2
        return 1
    end
    set -l rec (string split \t (string trim < $f))
    set -l sid $rec[1]
    if test (count $rec) -ge 2; and test -n "$rec[2]"; and test "$rec[2]" != (pwd)
        echo "cl: that session lives in $rec[2]" >&2
    end
    claude --dangerously-skip-permissions --resume $sid $argv
end
