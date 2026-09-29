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

# Kitty: mkhmtdots-like feel, but no forced shell.
cp "$ROOT/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
cp "$ROOT/hypr/animated-wallpaper.sh" "$HOME/.config/hypr/scripts/animated-wallpaper.sh"
chmod +x "$HOME/.config/hypr/scripts/animated-wallpaper.sh"

# Hyprland 0.55+ uses Lua. Prefer Lua when present.
if [ -f "$HOME/.config/hypr/hyprland.lua" ]; then
    cp "$ROOT/hypr/keybinds.lua" "$HOME/.config/hypr/configs/hybrid-keybinds.lua"
    LUA_LINE='dofile(os.getenv("HOME") .. "/.config/hypr/configs/hybrid-keybinds.lua")'
    if ! grep -Fqx "$LUA_LINE" "$HOME/.config/hypr/hyprland.lua"; then
        printf '\n-- Serpantinum look + mkhmtdots controls\n%s\n' "$LUA_LINE" >> "$HOME/.config/hypr/hyprland.lua"
    fi
    echo "Installed for Hyprland Lua config."
else
    cp "$ROOT/hypr/keybinds.conf" "$HOME/.config/hypr/configs/hybrid-keybinds.conf"
    touch "$HOME/.config/hypr/hyprland.conf"
    CONF_LINE='source = ~/.config/hypr/configs/hybrid-keybinds.conf'
    if ! grep -Fqx "$CONF_LINE" "$HOME/.config/hypr/hyprland.conf"; then
        printf '\n# Serpantinum look + mkhmtdots controls\n%s\n' "$CONF_LINE" >> "$HOME/.config/hypr/hyprland.conf"
    fi
    echo "Installed for legacy Hyprland conf config."
fi

# IMPORTANT: Serpantinum settings are intentionally untouched.
echo
echo "Serpantinum appearance/settings were NOT modified."
echo "Backup: $BACKUP"
echo
echo "Controls:"
echo "  Super+T        centered floating Kitty"
echo "  Super+Shift+T  normal tiled Kitty"
echo "  Super+Q        close focused window"
echo "  Super+A        Serpantinum launcher"
echo "  Super+W        Serpantinum wallpaper UI"
echo "  Super+E        Thunar"
echo "  Super+F        toggle floating"
echo "  Super+1..0     workspaces"
echo
echo "Log into Hyprland after installation. Hyprland Lua config loads automatically."
