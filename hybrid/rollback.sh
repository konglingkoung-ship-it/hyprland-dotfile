#!/usr/bin/env bash
set -euo pipefail

BASE="$HOME/.config-backups"
if [ ! -d "$BASE" ]; then
  echo "No backup directory found: $BASE"
  exit 1
fi

LATEST="$(find "$BASE" -maxdepth 1 -type d -name 'hybrid-serpantinum-mkhmtdots-*' -printf '%T@ %p\n' 2>/dev/null | sort -nr | head -n1 | cut -d' ' -f2-)"
if [ -z "${LATEST:-}" ] || [ ! -d "$LATEST" ]; then
  echo "No hybrid backup found."
  exit 1
fi

echo "Restoring from:"
echo "  $LATEST"
echo

mkdir -p "$HOME/.config/kitty" "$HOME/.config/hypr" "$HOME/.config/serpantinum"

[ -f "$LATEST/kitty.conf" ] && cp -a "$LATEST/kitty.conf" "$HOME/.config/kitty/kitty.conf"
[ -f "$LATEST/hyprland.lua" ] && cp -a "$LATEST/hyprland.lua" "$HOME/.config/hypr/hyprland.lua"
[ -f "$LATEST/hyprland.conf" ] && cp -a "$LATEST/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
[ -f "$LATEST/serpantinum-settings.json" ] && cp -a "$LATEST/serpantinum-settings.json" "$HOME/.config/serpantinum/settings.json"

rm -f "$HOME/.config/hypr/configs/hybrid-keybinds.lua"
rm -f "$HOME/.config/hypr/configs/hybrid-keybinds.conf"

echo "Rollback complete."
echo "Log out and back into Hyprland, or reboot."
