#!/bin/sh

playerctl -l | dmenu | xargs -I{} playerctl -p {} play-pause
