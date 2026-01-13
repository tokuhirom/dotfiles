#!/usr/bin/env bash

# Ensure aerotag is in PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Tag definitions
TAG_NAMES=("R" "C" "D" "Z" "G" "A" "E")
TAG_BITS=(1 2 4 8 16 32 64)

# Get focused window's tags
get_window_tags() {
    local json
    json=$(aerotag query window 2>/dev/null)
    if [ -z "$json" ]; then
        echo ""
        return
    fi

    # Extract tags value
    local tags
    tags=$(echo "$json" | grep -o '"tags":[0-9]*' | cut -d':' -f2)

    if [ -z "$tags" ] || [ "$tags" = "0" ]; then
        echo ""
        return
    fi

    # Convert bitmask to tag names
    local result=""
    for i in "${!TAG_BITS[@]}"; do
        local bit="${TAG_BITS[$i]}"
        if (( (tags & bit) != 0 )); then
            if [ -n "$result" ]; then
                result="$result,"
            fi
            result="$result${TAG_NAMES[$i]}"
        fi
    done

    echo "$result"
}

TAGS=$(get_window_tags)

if [ -n "$TAGS" ]; then
    sketchybar --set "$NAME" label="[$TAGS]" drawing=on
else
    sketchybar --set "$NAME" label="" drawing=off
fi
