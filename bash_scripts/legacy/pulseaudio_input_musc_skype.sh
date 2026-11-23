#!/bin/bash

MICROPHONE="alsa_input.pci-0000_00_1b.0.analog-stereo"
SPEAKERS="alsa_output.pci-0000_00_1b.0.analog-stereo"

# Create the null sinks
# virtual1 gets your audio source (mplayer ...) only
# virtual2 gets virtual1 + micro
pactl load-module module-null-sink sink_name=virtual1 sink_properties=device.description="virtual1"
pactl load-module module-null-sink sink_name=virtual2 sink_properties=device.description="virtual2"

# Now create the loopback devices, all arguments are optional and can be configured with pavucontrol
pactl load-module module-loopback source=virtual1.monitor sink=$SPEAKERS
pactl load-module module-loopback source=virtual1.monitor sink=virtual2
pactl load-module module-loopback source=$MICROPHONE sink=virtual2
