# Serpantinum Look + mkhmtdots Controls

This branch is intentionally **not a visual merge**.

**Serpantinum stays responsible for the desktop look:** bar, shell, widgets, wallpaper UI, notifications, launcher, theme and overall appearance.

The mkhmtdots side is used only for the workflow you wanted:

- **Super+T** → centered floating Kitty popup
- **Super+Shift+T** → normal tiled Kitty
- **Super+Q** → close focused window
- **Super+A** → Serpantinum app launcher
- **Super+W** → Serpantinum wallpaper panel
- **Super+E** → Thunar
- **Super+F** → toggle floating
- **Super+J** → toggle split
- **Super+arrows** → focus windows
- **Super+1..0** → workspaces
- **Super+Shift+1..0** → move window to workspace
- old mouse move/resize, volume, brightness and screenshot controls
- JetBrains Mono Kitty with transparency, but no hard-coded shell path

The installer **does not edit `~/.config/serpantinum/settings.json`**. Your Serpantinum appearance stays exactly as it is.

## Install

```bash
cd ~/hyprland-dotfile
git fetch origin
git checkout hybrid-serpantinum-mkhmtdots
git pull
chmod +x hybrid/install.sh
./hybrid/install.sh
hyprctl reload
```

## Kitty behavior

`Super+T` launches:

```
kitty --class popup-kitty
```

Hyprland immediately makes only that class floating, centered, and 900×600.

Use `Super+Shift+T` when you want a normal tiled terminal.

## Wallpaper

Serpantinum remains the primary wallpaper system:

```bash
serpantinum msg open wallpaper
```

The included `animated-wallpaper.sh` is optional for experimenting with `awww`; it is not started automatically because that could conflict with Serpantinum's wallpaper layer.

## Backups

Before changing Kitty or Hyprland files, the installer backs them up under:

```
~/.config-backups/hybrid-serpantinum-mkhmtdots-<timestamp>/
```
