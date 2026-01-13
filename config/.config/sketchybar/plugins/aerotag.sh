#!/usr/bin/env bash

# Ensure aerotag is in PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Monitor ID passed as argument
MONITOR_ID="$1"

# Tag definitions (bitmask -> name)
TAG_NAMES=("R" "C" "D" "Z" "G" "A" "E")
TAG_IDS=(1 2 3 4 5 6 7)
TAG_BITS=(1 2 4 8 16 32 64)

# Get aerotag state for specific monitor
get_aerotag_state() {
    local monitor_id="$1"
    local state
    state=$(aerotag query state 2>/dev/null)
    if [ -z "$state" ]; then
        return
    fi
    # Extract monitor-specific data using python for reliable JSON parsing
    echo "$state" | python3 -c "
import json, sys
data = json.load(sys.stdin)
m = data['monitors'].get('$monitor_id', {})
print(m.get('selected_tags', 0), m.get('occupied_tags', 0))
" 2>/dev/null
}

# Update all tag items for this monitor
update_tags() {
    if [ -z "$MONITOR_ID" ]; then
        return
    fi

    local state
    state=$(get_aerotag_state "$MONITOR_ID")

    if [ -z "$state" ]; then
        return
    fi

    local selected_tags occupied_tags
    read -r selected_tags occupied_tags <<< "$state"

    for i in "${!TAG_IDS[@]}"; do
        local tag_id="${TAG_IDS[$i]}"
        local tag_bit="${TAG_BITS[$i]}"
        local item_name="aerotag.m${MONITOR_ID}.${tag_id}"

        local is_selected=false
        local is_occupied=false

        if (( (selected_tags & tag_bit) != 0 )); then
            is_selected=true
        fi

        if (( (occupied_tags & tag_bit) != 0 )); then
            is_occupied=true
        fi

        if [ "$is_selected" = true ]; then
            # Selected tag: highlight background
            sketchybar --set "$item_name" background.drawing=on background.color=0xff6699ff label.color=0xffffffff
        elif [ "$is_occupied" = true ]; then
            # Occupied but not selected: dim highlight
            sketchybar --set "$item_name" background.drawing=on background.color=0x44ffffff label.color=0xffffffff
        else
            # Empty and not selected
            sketchybar --set "$item_name" background.drawing=off label.color=0x66ffffff
        fi
    done
}

update_tags
