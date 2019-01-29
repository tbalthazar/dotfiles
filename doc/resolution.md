# Resolution

- By default, when running startx, resolutions is set to 96dpi.

## Commands

- Get current resolution: `xdpyinfo | grep -B 2 resolution`
- List supported screen resulutions: `xrandr` (prefered has a `+`, current has a `*`)
- Manually add unlisted resolutions:
  ```bash
  # create a modline with the resolution/rate you want
  $ gtf 3840 2160 30.0
  # create a new mode using the modeline
  $ xrandr --newmode "3840x2160_30.00" 338.75 3840 4080 4488 5136 2160 2163 2168 2200 -hsync +vsync
  $ xrandr --addmode DP1 "3840x2160_30.00"
  # switch to that new resolution, specifying `--dpi`
  $ xrandr --output VIRTUAL1 --off --output eDP1 --off --output DP1 --primary --mode "3840x2160_30.00" --pos 0x0 --rotate normal --output HDMI2 --off --output HDMI1 --off --output DP2 --off --dpi 135
  ```
  
## Config

### `.Xresources`

- set resolution in `.Xresources`:
  - external screen: `Xft.dpi: 180`
  - internal screen: `Xft.dpi: 120`

### Firefox

- in `about:config`, find `devPixelsPerPx`, set it to `1.2` (default value was `-1.0`)

### TODO

- check this info about dpi for GDK apps and Firefox:
  - test GDKSCALE options as explained [here](https://wiki.archlinux.org/index.php/HiDPI#GDK_3.28GTK.2B_3.29) J
(and in the firefox specific section)
  - check [here](https://developer.gnome.org/gtk3/stable/gtk-x11.html)
  - info [about firefox dpi](https://wiki.debian.org/MonitorDPI)
