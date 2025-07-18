#!/bin/sh

export DISPLAY=:0
#export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export XAUTHORITY=/home/jl/.Xauthority

#BAT0=$(cat /sys/class/power_supply/BAT1/capacity)
BAT0=$(apm -l)

if [[ $BAT0 -lt 10 ]];then
	notify-send -u critical "=== LOW BATTERY ==="
fi
