# Serpantinum UI + mkhmtdots Controls

Goal: **keep the Serpantinum look**, while using the workflow/controls from mkhmtdots.

## What stays Serpantinum

- top taskbar / shell
- launcher UI
- wallpaper UI
- notifications and shell popouts
- theme and overall desktop appearance
- Serpantinum settings.json is not changed by the installer

## What comes from mkhmtdots-style workflow

- Super+T: centered floating popup Kitty
- Super+Shift+T: normal tiled Kitty
- Super+Q: close focused window
- Super+A: Serpantinum app launcher
- Super+W: Serpantinum wallpaper UI
- Super+E: Thunar
- Super+F: toggle floating
- Super+J: toggle split
- Super+arrows: move focus
- Super+1..0: switch workspaces
- Super+Shift+1..0: move window to workspace
- Super+mouse: move/resize
- multimedia, brightness and screenshot binds

## Hyprland Lua support

Current Hyprland (0.55+) uses `~/.config/hypr/hyprland.lua`.
The installer detects this and installs `hybrid-keybinds.lua` automatically.
It falls back to the old conf format only if no Lua config exists.

## Kitty

Kitty uses a mkhmtdots-inspired transparent style without forcing `/usr/bin/zsh`.
Super+T uses class `popup-kitty`, with a Hyprland Lua window rule that makes it floating, centered and 900x600.

## Install from TTY / console

You do not need to be inside Hyprland:

```bash
cd ~/hyprland-dotfile
git fetch origin
git checkout hybrid-serpantinum-mkhmtdots
git reset --hard origin/hybrid-serpantinum-mkhmtdots
chmod +x hybrid/install.sh
./hybrid/install.sh
```

Then start/log into Hyprland normally.

## Safety

Before changing anything, the installer backs up Kitty, hyprland.lua/hyprland.conf, and Serpantinum settings under:

```
~/.config-backups/hybrid-serpantinum-mkhmtdots-<timestamp>/
```

Serpantinum settings are backed up but not edited.


## Project tools

After installation:

```bash
./hybrid/status.sh
```

checks Hyprland, Kitty, Serpantinum, required commands, active config references, and config errors.

If a future edit breaks the desktop:

```bash
./hybrid/rollback.sh
```

restores the newest timestamped backup created by the installer.

`Super+W` now calls a small wallpaper helper which opens the native Serpantinum wallpaper UI. This keeps wallpaper control inside the Serpantinum look instead of replacing it with another shell.
