# Finished Hybrid Desktop: Serpantinum UI + mkhmtdots Workflow

This setup is designed to be installed once from KDE/TTY and then be ready when you log into Hyprland.

## Desktop ownership

**Serpantinum handles the visible shell/UI:**
- top bar
- launcher
- wallpaper UI
- clipboard UI
- system/network panels
- lock UI
- notifications/popouts
- volume/brightness OSD
- screenshots

**mkhmtdots-style workflow controls Hyprland:**
- Super+T popup Kitty
- Super+Shift+T normal Kitty
- Super+Q close window
- Super+E Thunar
- Super+F floating
- Super+arrows focus
- Super+1..0 workspaces
- Super+Shift+1..0 move window

Extra Serpantinum controls:
- Super+A launcher
- Super+W wallpaper
- Super+V clipboard
- Super+D system panel
- Super+N network
- Super+H guide
- Super+R reload shell
- Super+L lock

## Automatic startup

The project installs a Hyprland Lua autostart file. On Hyprland login it automatically starts:
- serpantinumd
- clipboard text watcher
- clipboard image watcher
- EasyEffects when installed

No manual `serpantinumd start` is required after login.

## Install/update

From KDE or TTY:

```bash
cd ~/hyprland-dotfile
git fetch origin
git checkout hybrid-serpantinum-mkhmtdots
git reset --hard origin/hybrid-serpantinum-mkhmtdots
chmod +x hybrid/install.sh
./hybrid/install.sh
```

Then log out of KDE and choose Hyprland.

## Safety

Every install makes a timestamped backup in:

```
~/.config-backups/hybrid-serpantinum-mkhmtdots-<timestamp>/
```

Rollback:

```bash
cd ~/hyprland-dotfile
chmod +x hybrid/rollback.sh
./hybrid/rollback.sh
```

Status check:

```bash
cd ~/hyprland-dotfile
chmod +x hybrid/status.sh
./hybrid/status.sh
```
