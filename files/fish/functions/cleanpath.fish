function cleanpath
    set -gx BACKUP_PATH $PATH
    set -gx PATH $CLEAN_PATH

    echo "* Path is cleaned"
end
