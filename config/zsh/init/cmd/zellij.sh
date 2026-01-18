# -------------------------------------------------------------------------
# zellij helpers
# -------------------------------------------------------------------------

if which zellij &> /dev/null; then
    # zj: attach or create zellij session named after current directory
    function zj() {
        local sess_name=$(basename $(pwd))

        # Get matching sessions
        local matches=$(zellij list-sessions 2>/dev/null | grep -x "$sess_name")
        local match_count=$(echo "$matches" | grep -c .)

        # If multiple matches, use fzf to select
        if [[ $match_count -gt 1 ]]; then
            sess_name=$(echo "$matches" | fzf --prompt='Select Zellij session> ')
        fi

        # Attach or create session
        if [[ -n "$sess_name" ]]; then
            zellij attach "$sess_name" -c
        fi
    }
fi
