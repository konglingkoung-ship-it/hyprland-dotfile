-- Hybrid autostart: start the Serpantinum shell automatically with Hyprland
hl.on("hyprland.start", function()
    hl.exec_cmd("pgrep -x serpantinumd >/dev/null 2>&1 || serpantinumd start")
    hl.exec_cmd("pgrep -f 'wl-paste --type text --watch cliphist store' >/dev/null 2>&1 || wl-paste --type text --watch cliphist store")
    hl.exec_cmd("pgrep -f 'wl-paste --type image --watch cliphist store' >/dev/null 2>&1 || wl-paste --type image --watch cliphist store")
    hl.exec_cmd("command -v easyeffects >/dev/null 2>&1 && systemctl --user start easyeffects || true")
end)
