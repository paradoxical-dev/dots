#!/bin/sh

# Define the theme using the generated theme file from home-manager
theme=$(cat "$HOME/.system-theme" 2>/dev/null)
if [ -z "$theme" ]; then
    echo "Error: ~/.system-theme file is not set. Please ensure it is configured correctly in your environment."
    exit 1
fi

echo "Theme: $theme"
echo "System theme: $SYSTEM_THEME"

# Check if the SYSTEM_THEME environment variable is set
if [ -z "$SYSTEM_THEME" ]; then
    echo "Warning: SYSTEM_THEME is not set in the environment. Assuming new theme."
else
    # Do not run if the theme matches the current theme
    if [ "$theme" = "$SYSTEM_THEME" ]; then
        echo "System theme is already set to $SYSTEM_THEME. Skipping theme switch."
        exit 0
    fi
fi

# Set the SYSTEM_THEME environment variable to match new theme
export SYSTEM_THEME="$theme"

# Check if the hyprpanel theme file exists
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
    echo "Error: Failed to restart hyprpaper.service. Check the status for more details."
    exit 1
fi
