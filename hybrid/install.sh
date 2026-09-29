#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/.config-backups/hybrid-serpantinum-mkhmtdots-$STAMP"

mkdir -p "$BACKUP"
mkdir -p "$HOME/.config/kitty" "$HOME/.config/hypr/configs" "$HOME/.config/hypr/scripts"

[ -f "$HOME/.config/kitty/kitty.conf" ] && cp -a "$HOME/.config/kitty/kitty.conf" "$BACKUP/kitty.conf"
[ -f "$HOME/.config/hypr/hyprland.conf" ] && cp -a "$HOME/.config/hypr/hyprland.conf" "$BACKUP/hyprland.conf"
[ -f "$HOME/.config/serpantinum/settings.json" ] && cp -a "$HOME/.config/serpantinum/settings.json" "$BACKUP/serpantinum-settings.json"

# Keep Serpantinum's look/settings untouched.
# Only install Kitty styling + mkhmtdots-style controls.
cp "$ROOT/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
cp "$ROOT/hypr/keybinds.conf" "$HOME/.config/hypr/configs/hybrid-keybinds.conf"
cp "$ROOT/hypr/animated-wallpaper.sh" "$HOME/.config/hypr/scripts/animated-wallpaper.sh"
chmod +x "$HOME/.config/hypr/scripts/animated-wallpaper.sh"

HYPR="$HOME/.config/hypr/hyprland.conf"
touch "$HYPR"
SOURCE_LINE='source = ~/.config/hypr/configs/hybrid-keybinds.conf'
if ! grep -Fqx "$SOURCE_LINE" "$HYPR"; then
  printf '\n# Serpantinum look + mkhmtdots controls\n%s\n' "$SOURCE_LINE" >> "$HYPR"
fi

echo "Installed hybrid controls without changing Serpantinum appearance."
echo "Backup: $BACKUP"
echo
echo "Controls:"
echo "  Super+T        floating popup Kitty"
echo "  Super+Shift+T  normal tiled Kitty"
echo "  Super+Q        close focused window"
echo "  Super+A        Serpantinum launcher"
echo "  Super+W        Serpantinum wallpaper panel"
echo "  Super+E        Thunar"
echo "  Super+F        toggle floating"
echo
echo "Next:"
echo "  hyprctl reload"
