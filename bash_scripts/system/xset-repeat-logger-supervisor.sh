#!/bin/bash
# Keeps xset-repeat-logger.sh running. bspwmrc's launch guard checks this
# supervisor's own name, not the inner watcher's -- a bare restart loop
# wrapped directly around the watcher would only match that pgrep pattern
# while the watcher itself happens to be running, not during the sleep gap
# between restarts, so a bspwm reload landing in that gap would spawn a
# second supervisor. This script's name stays matchable for its whole
# lifetime instead, since the loop runs in this same process.
#
# If the watcher dies for any reason (crash, broken pipe, OOM), it's back
# within 2s instead of silently gone until the next login or bspwm reload.
log="${XDG_CACHE_HOME:-$HOME/.cache}/xset-repeat-rate.log"
while true; do
    "$HOME/bin/bash_scripts/system/xset-repeat-logger.sh"
    echo "$(date '+%Y-%m-%d %H:%M:%S') watcher exited, restarting in 2s" >> "$log"
    sleep 2
done
