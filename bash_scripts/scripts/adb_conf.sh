#!/bin/bash

#This script establishes wireless adb connection. Default ip is 102.168.0.101 if no arguments are supplied.
#If one argument is supplied the it connect to that ip.

adb tcpip 5555
if [ $# -eq 0 ]
then
        adb connect 192.168.0.102
        ip=192.168.0.102
elif [ $# -eq 1 ]
then
        adb connect $1
        ip=$1
else
        echo "Only zero or one argument is allowed"
fi

