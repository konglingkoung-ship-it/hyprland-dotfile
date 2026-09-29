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

cp "$ROOT/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
cp "$ROOT/hypr/keybinds.conf" "$HOME/.config/hypr/configs/hybrid-keybinds.conf"
cp "$ROOT/hypr/animated-wallpaper.sh" "$HOME/.config/hypr/scripts/animated-wallpaper.sh"
chmod +x "$HOME/.config/hypr/scripts/animated-wallpaper.sh"

HYPR="$HOME/.config/hypr/hyprland.conf"
touch "$HYPR"
SOURCE_LINE='source = ~/.config/hypr/configs/hybrid-keybinds.conf'
if ! grep -Fqx "$SOURCE_LINE" "$HYPR"; then
  printf '\n# Hybrid mkhmtdots-style keybinds\n%s\n' "$SOURCE_LINE" >> "$HYPR"
fi

# Preserve the user's complete Serpantinum settings and only patch the visual fields.
SETTINGS="$HOME/.config/serpantinum/settings.json"
if [ -f "$SETTINGS" ]; then
  python3 - "$SETTINGS" <<'PY'
import json, sys
p=sys.argv[1]
with open(p, "r", encoding="utf-8") as f:
    data=json.load(f)
bar=data.setdefault("bar", {})
bar["opacity"]=65
bar["style"]="fill"
theme=data.setdefault("theme", {})
theme["fontFamily"]="JetBrains Mono"
theme["borderRadius"]=14
with open(p, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write("\n")
PY
fi

echo "Installed hybrid config."
echo "Backup: $BACKUP"
echo
echo "Next:"
echo "  hyprctl reload"
echo "  serpantinumd stop && serpantinumd start"
