#!/usr/bin/env bash
# Start (or restart) the polybar bar "main". Called from bspwmrc; also safe to
# run by hand or on a WM reload (super+alt+r).

DIR="${XDG_CONFIG_HOME:-$HOME/.config}/polybar"
LOG="${XDG_CACHE_HOME:-$HOME/.cache}/polybar.log"

# Kill any running bar and wait for it to fully exit, so the new one never fights
# the old one for the system tray or IPC.
killall -q polybar 2>/dev/null || true
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 0.1; done

# Wait until bspwm's IPC answers before launching. On a cold start, bspwmrc can
# run this before the socket is ready; polybar's bspwm (workspaces) module then
# comes up empty or the bar doesn't appear at all -- the intermittent "polybar
# failed on startup". Bounded to ~5s so it can never hang.
for _ in $(seq 1 50); do
    bspc query -M >/dev/null 2>&1 && break
    sleep 0.1
done

# No -q: keep output in a log so any future failure is diagnosable.
polybar main -c "$DIR/config.ini" >>"$LOG" 2>&1 &
