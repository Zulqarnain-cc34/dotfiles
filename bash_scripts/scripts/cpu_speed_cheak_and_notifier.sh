#!/bin/bash


cpu_speed=$(lscpu | awk  '/CPU MHz:/ {print $3}')
cpu_speed_limit=800

if [[ $((10#${cpu_speed%.*})) -le ${cpu_speed_limit} ]]
then
    notify-send "Alert!: Low Cpu Speed" "Cpu speed is ${cpu_speed} MHz and is below critical limit of ${cpu_speed_limit} MHz" 
fi

