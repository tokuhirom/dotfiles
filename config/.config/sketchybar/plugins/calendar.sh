#!/bin/bash

# Get next event from 'garoon sync' calendar
CALENDAR_NAME="garoon sync"

# Get current/next event using AppleScript
RESULT=$(osascript -e "
set now to current date
set endTime to now + (24 * 60 * 60) -- 24 hours from now

-- Get today's date (midnight)
set todayStart to now - (time of now)
set tomorrowStart to todayStart + (24 * 60 * 60)

tell application \"Calendar\"
    set targetCal to first calendar whose name is \"$CALENDAR_NAME\"

    -- First check for ongoing events
    set ongoingEvents to (every event of targetCal whose start date <= now and end date >= now)

    if (count of ongoingEvents) > 0 then
        set currentEvent to item 1 of ongoingEvents
        set eventTitle to summary of currentEvent
        set eventEnd to end date of currentEvent

        set h to (hours of eventEnd) as string
        set m to (minutes of eventEnd) as string
        if length of h < 2 then set h to \"0\" & h
        if length of m < 2 then set m to \"0\" & m

        return \"ONGOING|~\" & h & \":\" & m & \" \" & eventTitle
    end if

    -- Check for upcoming events
    set upcomingEvents to (every event of targetCal whose start date > now and start date <= endTime)

    if (count of upcomingEvents) = 0 then
        return \"\"
    end if

    -- Sort by start date and get the first one
    set nextEvent to item 1 of upcomingEvents
    set minDate to start date of nextEvent

    repeat with evt in upcomingEvents
        if start date of evt < minDate then
            set nextEvent to evt
            set minDate to start date of evt
        end if
    end repeat

    set eventTitle to summary of nextEvent
    set eventStart to start date of nextEvent

    set h to (hours of eventStart) as string
    set m to (minutes of eventStart) as string
    if length of h < 2 then set h to \"0\" & h
    if length of m < 2 then set m to \"0\" & m

    -- Check if event is tomorrow
    set prefix to \"\"
    if eventStart >= tomorrowStart then
        set prefix to \"明日 \"
    end if

    return \"UPCOMING|\" & prefix & h & \":\" & m & \" \" & eventTitle
end tell
" 2>/dev/null)

if [ -z "$RESULT" ]; then
    sketchybar --set "$NAME" label="" drawing=off
    exit 0
fi

# Parse result
STATUS=$(echo "$RESULT" | cut -d'|' -f1)
EVENT_INFO=$(echo "$RESULT" | cut -d'|' -f2-)

# Truncate if too long
if [ ${#EVENT_INFO} -gt 35 ]; then
    EVENT_INFO="${EVENT_INFO:0:32}..."
fi

if [ "$STATUS" = "ONGOING" ]; then
    # Ongoing event: red/orange icon color
    sketchybar --set "$NAME" label="$EVENT_INFO" drawing=on icon.color=0xffff6b6b
else
    # Upcoming event: normal white icon color
    sketchybar --set "$NAME" label="$EVENT_INFO" drawing=on icon.color=0xffffffff
fi
