#!/bin/sh
change-resolution 180
xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --off --output VGA1 --off --dpi 180
i3 restart
