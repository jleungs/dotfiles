#!/bin/bash
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export XAUTHORITY=/home/jl/.Xauthority

BAT0=$(cat /sys/class/power_supply/BAT1/capacity)

if [[ $BAT0 -lt 110 ]];then
	/usr/bin/notify-send -u critical "=== LOW BATTERY ==="
fi
