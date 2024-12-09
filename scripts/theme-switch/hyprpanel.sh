#!/bin/sh

theme=$(cat "$HOME/.system-theme" 2>/dev/null)
if [ -z "$theme" ]; then
    echo "Error: SYSTEM_THEME file is not set. Please ensure it is configured correctly in your environment."
    exit 1
fi

export SYSTEM_THEME="$theme"

hyprpanel_theme_file="$HOME/dots/user/de/hypr/hyprpanel/$SYSTEM_THEME.json"
if [ ! -f "$hyprpanel_theme_file" ]; then
    echo "Error: Theme file $hyprpanel_theme_file does not exist."
    exit 1
fi

echo "Changing system theme to $SYSTEM_THEME ..."

echo "Changing Hyprpanel theme to $hyprpanel_theme_file"
if ! hyprpanel -r "useTheme('$hyprpanel_theme_file')"; then
    echo "Error: Failed to apply Hyprpanel theme."
    exit 1
fi

echo "Updating wallpaper ..."
if ! systemctl --user restart hyprpaper.service; then
    echo "Error: Failed to restart hyprpaper.service. Ensure the service is correctly configured."
    exit 1
fi
