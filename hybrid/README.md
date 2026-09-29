# Hybrid Serpantinum + mkhmtdots

This branch keeps **Serpantinum** as the desktop shell/taskbar and brings back the parts of **mkhmtdots** that match the old workflow:

- Super+T opens Kitty
- Super+Q closes the focused window
- Super+A opens the Serpantinum launcher
- Super+W opens the Serpantinum wallpaper panel
- Super+E opens Thunar
- Super+F toggles floating
- Super+1..0 switches workspaces
- Super+Shift+1..0 moves windows
- JetBrains Mono Kitty styling inspired by mkhmtdots
- Transparent Kitty
- Transparent Serpantinum bar while keeping the existing Serpantinum settings
- Optional animated wallpaper helper using awww + matugen

## Safety

The installer makes timestamped backups before changing files.
It does not replace the whole Hyprland config and it does not remove Serpantinum.

## Install

```bash
cd ~/hyprland-dotfile
git fetch origin
git checkout hybrid-serpantinum-mkhmtdots
chmod +x hybrid/install.sh
./hybrid/install.sh
```

Then reload Hyprland:

```bash
hyprctl reload
```

Restart Serpantinum:

```bash
serpantinumd stop
serpantinumd start
```

## Animated wallpaper

This is optional because Serpantinum also manages wallpapers.

```bash
~/.config/hypr/scripts/animated-wallpaper.sh ~/Pictures/Wallpapers/your-wallpaper.gif
```

If Serpantinum's wallpaper layer covers awww, keep using Serpantinum's wallpaper panel instead:
```bash
serpantinum msg open wallpaper
```
