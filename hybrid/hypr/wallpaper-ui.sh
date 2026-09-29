#!/usr/bin/env bash
set -euo pipefail

if command -v serpantinum >/dev/null 2>&1; then
  serpantinum msg open wallpaper
  exit $?
fi

echo "Serpantinum CLI not found."
echo "Optional fallback: use animated-wallpaper.sh with a local image/GIF."
exit 1
