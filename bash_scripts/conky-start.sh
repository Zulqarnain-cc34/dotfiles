#!/bin/sh
#conky -q -c /home/precision/.config/conky/conky2/conkyrc2 &
#conky -q -c /home/precision/.config/conky/conky1/conkyrc1 &

killall -q conky
sleep 2
conky -q -c /home/precision/.config/conky/conky3/conkyrc &
