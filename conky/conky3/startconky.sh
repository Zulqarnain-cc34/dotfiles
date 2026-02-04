#! /bin/bash
killall -q conky

sleep 5

conky -c "$HOME/.config/conky/conky3/conkyrc"
