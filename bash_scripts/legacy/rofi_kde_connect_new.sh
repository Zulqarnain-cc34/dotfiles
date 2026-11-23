#!/bin/bash

kdeconnect-cli -l --name-only

device_id=($(kdeconnect-cli -l --id-only))

echo "${device_id[@]}"
