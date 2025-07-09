#!/bin/sh

becho() {
	echo -n " [ $1 ] "
}

bstatus() {
	# CPU
	becho "CPU `sysctl -n hw.sensors.cpu0.temp0 | cut -d'.' -f1`"

	# BACKLIGHT
	becho "BRI `xbacklight -get | cut -d'.' -f1`"

	# VOLUME
	if [ `sndioctl output.mute | cut -d'=' -f2` -gt 0 ]; then
		becho "MUTED"
	else
		vol=`sndioctl output.level | cut -d'=' -f2`
		becho "VOL `bc -e \"($vol*100)/1\"`"
	fi

	# BATTERY
	bat="BAT"
	if [ `apm -a` -gt 0 ]; then
		bat="${bat}+"
	fi
	bat="${bat} `apm -l`%"

	becho "$bat"

	# DATE
	becho "`date +"%a %F %R"`"
}

main() {
	while true; do
		xsetroot -name "`bstatus`" &
		sleep 1
		wait
	done
}
main
