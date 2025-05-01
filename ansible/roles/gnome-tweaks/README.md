# Gnome Tweaks Role

## Notes

- to configure Gnome extension, [see exmaple in Omakub here](https://github.com/basecamp/omakub/blob/32330a78a9fd683e145f6c1d0876b362d931b366/install/desktop/set-gnome-extensions.sh#L22-L38) (note that the `glib-comile-schemas` is required to be able to modify extension)
- to know what's the schema for an extension (note the `/org/gnome/...` is not a file system path):
```
dconf dump "/org/gnome/shell/extensions/tactile/" > tactile.conf
```
- and to restore it:
```
dconf load "/org/gnome/shell/extensions/tactile/" < tactile.conf

