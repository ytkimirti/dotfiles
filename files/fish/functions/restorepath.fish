function restorepath
    set -gx PATH "$BACKUP_PATH"

    echo "* Path is restored"
end
