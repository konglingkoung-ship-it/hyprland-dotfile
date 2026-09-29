#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 /path/to/wallpaper.(png|jpg|gif)"
  exit 1
fi

WALL="$1"
if [ ! -f "$WALL" ]; then
  echo "Wallpaper not found: $WALL"
  exit 1
fi

if ! command -v awww >/dev/null 2>&1; then
  echo "awww is not installed. Install it first."
  exit 1
fi

pgrep -x awww-daemon >/dev/null 2>&1 || (awww-daemon >/dev/null 2>&1 & sleep 1)
awww img --transition-type center --transition-step 90 "$WALL"

if command -v matugen >/dev/null 2>&1; then
  matugen image "$WALL" --type scheme-content --mode dark --prefer saturation || true
  pkill -USR1 kitty 2>/dev/null || true
  hyprctl reload >/dev/null 2>&1 || true
fi
