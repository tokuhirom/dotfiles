# -------------------------------------------------------------------------
# tmux helpers
# -------------------------------------------------------------------------

if which tmux &> /dev/null; then
    # tx: attach or create tmux session named after current directory
    function tx() {
        local sess_name=$(basename $(pwd) | tr '.' '_')

        if tmux has-session -t "$sess_name" 2>/dev/null; then
            tmux attach-session -t "$sess_name"
        else
            tmux new-session -s "$sess_name"
        fi
    }
fi
