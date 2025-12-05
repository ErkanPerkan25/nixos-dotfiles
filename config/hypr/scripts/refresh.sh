#!/usr/bin/env bash

SCRIPTDIR="$HOME/.config/hypr/scripts"
USEER_SCRIPT_DIR="$HOME/.config/hypr/userScripts"

find_exits(){
    if [ -e "$1" ]; then
        return 0 # File Exits
    else
        return 1 # File does not extis
    fi
}

# Kill already running process
_ps=(waybar rofi)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"
    fi
done

sleep 0.3

# Restart Waybar
waybar &

exit 0
