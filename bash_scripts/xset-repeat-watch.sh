#!/bin/bash
# Re-apply the keyboard repeat rate after resuming from suspend.
#
# `xset r rate 300 50` in bspwmrc only runs once, at X session start. It has
# been observed going back to a slower default rate mid-session, with no
# setxkbmap/xmodmap call anywhere in this repo to blame (checked). The known
# X11 behavior that matches: some keyboard/input drivers reset the X
# server's repeat rate when the device comes back after a suspend/resume
# cycle. Listen for systemd-logind's own PrepareForSleep signal (fires with
# argument "false" on wake) and reassert the rate then.
dbus-monitor --system "type='signal',interface='org.freedesktop.login1.Manager',member='PrepareForSleep'" |
while read -r line; do
    [[ "$line" == *"boolean false"* ]] && xset r rate 300 50
done
