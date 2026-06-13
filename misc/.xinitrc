#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Basic settings
xset s off -dpms

xinput set-prop 8 153 1.00000, 0.000000, 0.000000, 0.000000, 1.00000, 0.000000, 0.000000, 0.000000, 1.000000
setxkbmap gb
# lanuch polkit auth agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# Autostart programs
firefox &
nm-applet &
dunst &
# Start tmux with neomutt and irssi
st -e sh -c 'tmux new-session -d -s "std" && tmux send -t std.0 "cat TODO" ENTER && tmux a' &
# Statusbar
/home/jl/.suckless/bar.sh &
# VPN
mullvad-vpn &

# Window Manager
exec dwm
