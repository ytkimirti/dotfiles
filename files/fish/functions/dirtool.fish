function dirtool
    set -l data_file ~/.local/share/dirtool/dirs

    if contains -- "$argv[1]" help --help -h
        echo "dirtool [query]  fuzzy-pick a saved dir and cd into it"
        echo "  save           save the current dir"
        echo "  saveall        save the current dir's children (glob entry)"
        echo "  list           print the raw entries"
        echo "  edit           edit the entries in vim"
        echo "  remove         fuzzy-pick an entry to delete"
        echo
        echo "entries: $data_file"
        return
    end

    if test "$argv[1]" = save
        mkdir -p ~/.local/share/dirtool
        set -l entry (pwd)
        if test -f $data_file; and grep -qxF "$entry" $data_file
            echo "Already saved: $entry"
        else
            echo $entry >> $data_file
            echo "Saved: $entry"
        end
        return
    end

    if test "$argv[1]" = saveall
        mkdir -p ~/.local/share/dirtool
        set -l entry (string join '' (pwd) '/*')
        if test -f $data_file; and grep -qxF "$entry" $data_file
            echo "Already saved: $entry"
        else
            echo $entry >> $data_file
            echo "Saved: $entry"
        end
        return
    end

    if test "$argv[1]" = list
        if test -f $data_file
            cat $data_file
        else
            echo "No directories saved yet."
        end
        return
    end

    if test "$argv[1]" = edit
        mkdir -p ~/.local/share/dirtool
        touch $data_file
        vim $data_file
        return
    end

    if test "$argv[1]" = remove
        if not test -f $data_file
            echo "No directories saved yet."
            return 1
        end
        set -l selected (cat $data_file | fzf --prompt="remove> " --height=40% --reverse --no-sort)
        if test -n "$selected"
            set -l tmp (mktemp)
            grep -vxF "$selected" $data_file > $tmp
            mv $tmp $data_file
            echo "Removed: $selected"
        end
        return
    end

    if not test -f $data_file
        echo "No directories saved yet. Run 'dirtool save' in a directory first."
        return 1
    end

    # Build fzf list, expanding glob entries (lines ending with /*)
    set -l list
    while read -l line
        if string match -rq '\*$' -- $line
            set -l base (string replace -r '/\*$' '' $line)
            set -a list $base
            for d in (find $base -maxdepth 1 -mindepth 1 -type d 2>/dev/null | sort)
                set -a list $d
            end
        else
            set -a list $line
        end
    end < $data_file

    # Drop dirs that no longer exist, and duplicates: an explicitly saved dir is
    # usually also produced by some other entry's glob.
    set -l dirs
    for item in $list
        set -l dir (string replace -r '/$' '' -- $item)
        test -d $dir; or continue
        contains -- $dir $dirs; and continue
        set -a dirs $dir
    end

    if test (count $dirs) -eq 0
        echo "No directories to show."
        return 1
    end

    set -l home_re (string escape --style=regex -- $HOME)
    set -l display_list
    for item in $dirs
        set -a display_list (string replace -r "^$home_re/" '~/' -- $item)
    end

    set -l selected (printf '%s\n' $display_list | fzf --prompt="goto> " --height=40% --reverse --no-sort --query="$argv[1]")
    if test -n "$selected"
        cd (string replace -r '^~/' "$HOME/" -- $selected)
    end
end
