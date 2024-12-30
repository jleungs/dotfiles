#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Basic settings
xset s off -dpms

if [[ "$(xrandr | grep " connected" | grep DP-2)" ]]; then
    xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output DP-2 --primary --mode 1440x900 --rate 75 --pos 1920x0 --rotate normal
fi

xinput set-prop 8 153 1.00000, 0.000000, 0.000000, 0.000000, 1.00000, 0.000000, 0.000000, 0.000000, 1.000000
setxkbmap se
# lanuch polkit auth agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Background
#feh --bg-fill /home/jl/Pictures/wallpapers/citylights.jpg

# Load nvidia settings
nvidia-settings -l
/usr/bin/prime-offload

# Autostart programs
firefox &
spotify &
nm-applet &
dunst &
# Start tmux with neomutt and irssi
st -e sh -c 'tmux new-session -d -s "std" && tmux send -t std.0 "cat TODO" ENTER && tmux a' &
# Statusbar
/home/jl/.suckless/bar.sh &
# VPN
mullvad-vpn &
# rime cantonese
fcitx5 &

# Window Manager
exec dwm
#exec startxfce4

