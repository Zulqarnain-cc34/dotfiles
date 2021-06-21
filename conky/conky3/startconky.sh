#! /bin/bash
killall -q conky

sleep 5

conky -c ~/.config/conky/conky3/conkyrc
