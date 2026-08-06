function opencode
    set -x OPENCODE_EXPERIMENTAL_WORKSPACES true
    # UPSTASH_BOX_API_KEY comes from conf.d/secrets.fish (gitignored)
    if not set -q UPSTASH_BOX_API_KEY
        echo "opencode: UPSTASH_BOX_API_KEY unset, see conf.d/secrets.fish" >&2
    end
    command opencode $argv
end
