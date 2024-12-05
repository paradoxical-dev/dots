#/bin/bash

# main terminal / system file editor
kitty --detach

sleep 0.1

hyprctl dispatch movewindowpixel exact 1125 85, activewindow
hyprctl dispatch resizewindowpixel exact 700 900, activewindow

# TODO: replace with visualizer and player

# music visualizer (terminal placeholder for now)
kitty --detach

sleep 0.1

hyprctl dispatch movewindowpixel exact 90 540, activewindow
hyprctl dispatch resizewindowpixel exact 700 450, activewindow

# music player
ags -b music-player -c ~/dots/user/pkgs/music/custom_player/config.js &

sleep 0.35

hyprctl dispatch movewindowpixel exact 300 80, activewindow
