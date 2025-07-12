export LANG=en_US.UTF-8
export ENV=$HOME/.kshrc
xsetroot -solid black
# disable $HOME core dumps
ulimit -Sc 0
# enable trackpoint scrolling
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation" 1 
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Button" 2 
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Axes" 6 7 4 5
# autostart
xidle &
$HOME/.suckless/bar.sh &
# run window manager
exec dwm
