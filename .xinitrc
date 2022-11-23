#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Basic settings
xset s off -dpms

#if [[ "$(xrandr | grep " connected" | grep DP-2)" ]]; then
#    xrandr ...
#fi

xinput set-prop 8 153 1.00000, 0.000000, 0.000000, 0.000000, 1.00000, 0.000000, 0.000000, 0.000000, 1.000000
setxkbmap se
# lanuch polkit auth agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Background
feh --bg-fill /home/jl/Pictures/wallpapers/citylights.jpg

# Load nvidia settings
nvidia-settings -l


# Autostart programs
firefox &
spotify &
dunst &
# Start tmux with neomutt and irssi
st -e sh -c 'tmux new-session -d -s "std" && tmux send -t std.0 "cat TODO" ENTER && tmux a' &
# Statusbar
/path/to/bar.sh &

# Window Manager
exec dwm
