#!/bin/bash
# Toggle dunst's do-not-disturb state and confirm it with a notification.
#
# Deliberately uses `set-pause-level 99`, not `dunstctl set-paused true`
# (which sets level 100): dunst only lets a notification bypass pause when
# its own override_pause_level is strictly GREATER than the current pause
# level. At 100, nothing can ever exceed it, so this toggle's own "DND: ON"
# confirmation (dunstrc's [dnd_toggle_confirm] rule, override_pause_level =
# 100) would be silently swallowed. 99 leaves that rule room to still fire.

if [[ "$(dunstctl get-pause-level)" -gt 0 ]]; then
    dunstctl set-pause-level 0
    state="OFF"
else
    dunstctl set-pause-level 99
    state="ON"
fi

dunstify -a "dunst" -u low --stack-tag dnd "Do not disturb: $state"
