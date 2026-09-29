#!/usr/bin/env bash
set -u

ok=0
warn=0

check_cmd() {
  local cmd="$1"
  if command -v "$cmd" >/dev/null 2>&1; then
    printf "[OK]   %-14s %s\n" "$cmd" "$(command -v "$cmd")"
    ok=$((ok+1))
  else
    printf "[MISS] %-14s not found\n" "$cmd"
    warn=$((warn+1))
  fi
}

echo "Hybrid desktop status"
echo "====================="
check_cmd Hyprland
check_cmd kitty
check_cmd serpantinum
check_cmd serpantinumd
check_cmd thunar
check_cmd wpctl
check_cmd brightnessctl
check_cmd hyprshot
check_cmd cliphist
check_cmd rofi

echo
if [ -f "$HOME/.config/hypr/hyprland.lua" ]; then
  echo "[OK]   Hyprland Lua config: ~/.config/hypr/hyprland.lua"
else
  echo "[WARN] Hyprland Lua config missing"
fi

if grep -Fq 'hybrid-keybinds.lua' "$HOME/.config/hypr/hyprland.lua" 2>/dev/null; then
  echo "[OK]   Hybrid Lua keybinds loaded by config"
else
  echo "[WARN] Hybrid Lua keybinds not referenced"
fi

if [ -f "$HOME/.config/hypr/configs/hybrid-keybinds.lua" ]; then
  echo "[OK]   Hybrid keybind file installed"
else
  echo "[WARN] Hybrid keybind file missing"
fi

if [ -f "$HOME/.config/kitty/kitty.conf" ]; then
  echo "[OK]   Kitty config installed"
  if grep -Eq '^[[:space:]]*shell[[:space:]]+/usr/bin/zsh' "$HOME/.config/kitty/kitty.conf"; then
    echo "[WARN] Kitty forces /usr/bin/zsh"
  else
    echo "[OK]   Kitty does not force zsh"
  fi
else
  echo "[WARN] Kitty config missing"
fi

if [ -f "$HOME/.config/serpantinum/settings.json" ]; then
  echo "[OK]   Serpantinum settings present"
else
  echo "[WARN] Serpantinum settings missing"
fi

echo
if [ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
  echo "[OK]   Currently inside Hyprland"
  hyprctl configerrors 2>/dev/null || true
else
  echo "[INFO] Not currently inside Hyprland"
fi

echo
echo "Checks passed: $ok"
echo "Missing/optional commands: $warn"
