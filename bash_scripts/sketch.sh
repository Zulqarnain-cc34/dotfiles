

arduino-cli compile -b arduino:avr:nano $dir && arduino-cli upload -b arduino:avr:nano -p /dev/ttyUSB0 $dir;;
