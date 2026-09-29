#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/.config-backups/hybrid-serpantinum-mkhmtdots-$STAMP"

mkdir -p "$BACKUP" "$HOME/.config/kitty" "$HOME/.config/hypr/configs" "$HOME/.config/hypr/scripts"

[ -f "$HOME/.config/kitty/kitty.conf" ] && cp -a "$HOME/.config/kitty/kitty.conf" "$BACKUP/kitty.conf"
[ -f "$HOME/.config/hypr/hyprland.lua" ] && cp -a "$HOME/.config/hypr/hyprland.lua" "$BACKUP/hyprland.lua"
[ -f "$HOME/.config/hypr/hyprland.conf" ] && cp -a "$HOME/.config/hypr/hyprland.conf" "$BACKUP/hyprland.conf"
[ -f "$HOME/.config/serpantinum/settings.json" ] && cp -a "$HOME/.config/serpantinum/settings.json" "$BACKUP/serpantinum-settings.json"

cp "$ROOT/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
cp "$ROOT/hypr/animated-wallpaper.sh" "$HOME/.config/hypr/scripts/animated-wallpaper.sh"
cp "$ROOT/hypr/wallpaper-ui.sh" "$HOME/.config/hypr/scripts/wallpaper-ui.sh"
chmod +x "$HOME/.config/hypr/scripts/animated-wallpaper.sh" "$HOME/.config/hypr/scripts/wallpaper-ui.sh"

if [ ! -f "$HOME/.config/hypr/hyprland.lua" ]; then
    echo "ERROR: ~/.config/hypr/hyprland.lua not found."
    echo "This hybrid project expects the current Hyprland Lua config."
    exit 1
fi

cp "$ROOT/hypr/keybinds.lua" "$HOME/.config/hypr/configs/hybrid-keybinds.lua"
cp "$ROOT/hypr/autostart.lua" "$HOME/.config/hypr/configs/hybrid-autostart.lua"
cp "$ROOT/hypr/style.lua" "$HOME/.config/hypr/configs/hybrid-style.lua"

for line in 'dofile(os.getenv("HOME") .. "/.config/hypr/configs/hybrid-style.lua")' 'dofile(os.getenv("HOME") .. "/.config/hypr/configs/hybrid-autostart.lua")' 'dofile(os.getenv("HOME") .. "/.config/hypr/configs/hybrid-keybinds.lua")'
do
    if ! grep -Fqx "$line" "$HOME/.config/hypr/hyprland.lua"; then
        printf '\n%s\n' "$line" >> "$HOME/.config/hypr/hyprland.lua"
    fi
done

echo
echo "Hybrid desktop setup installed."
echo "Backup: $BACKUP"
echo
echo "On the next Hyprland login:"
echo "  - Serpantinum daemon starts automatically"
echo "  - Serpantinum UI/bar/wallpaper shell starts with it"
echo "  - Kitty popup and mkhmtdots-style controls are active"
echo "  - clipboard watchers start automatically"
echo "  - Serpantinum handles volume/brightness/screenshot OSD"
echo
echo "Main keys:"
echo "  Super+T        popup Kitty"
echo "  Super+Shift+T  tiled Kitty"
echo "  Super+A        launcher"
echo "  Super+W        wallpaper"
echo "  Super+V        clipboard"
echo "  Super+D        system panel"
echo "  Super+N        network"
echo "  Super+H        guide"
echo "  Super+Q        close window"
echo "  Super+E        Thunar"
echo "  Super+F        float"
echo "  Super+1..0     workspaces"
echo
echo "You can now log out of KDE and log into Hyprland."
