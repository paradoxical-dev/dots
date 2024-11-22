#/bin/bash

# main terminal / system file editor
kitty --detach

hyprctl dispatch movewindowpixel exact 1125 85, activewindow
hyprctl dispatch resizewindowpixel exact 700 900, activewindow

# TODO: replace with visualizer and player

# music visualizer (terminal placeholder for now)
kitty --detach

hyprctl dispatch movewindowpixel exact 90 540, activewindow
hyprctl dispatch resizewindowpixel exact 700 450, activewindow

# music player (terminal placeholder for now)
kitty --detach

hyprctl dispatch movewindowpixel exact 300 80, activewindow
hyprctl dispatch resizewindowpixel exact 325 425, activewindow
