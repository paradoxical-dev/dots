#!/bin/sh

get_active_window() {
  hyprctl activewindow -j | jq -r '.address'
}

get_alpaca_window() {
  hyprctl clients -j | jq -r '.[] | select(.title == "Alpaca") | .address'
}

# grabs the x coordinates of the Alpaca window
alpaca_window_position() { 
  hyprctl clients -j | jq -r '.[] | select(.title == "Alpaca") | .at | .[0]'
}

MAIN_WINDOW=$(get_active_window)

sleep 0.5

if [[ -z "$MAIN_WINDOW" ]]; then
  echo "No active window found. Exiting."
  alpaca &
  exit 1
fi

alpaca &
sleep 0.25

ALPACA_WINDOW=$(get_alpaca_window)

while [[ -z "$ALPACA_WINDOW" ]]
do
  sleep 0.1
  ALPACA_WINDOW=$(get_alpaca_window)
done

echo "Main window: $MAIN_WINDOW"
echo "Alpaca window: $ALPACA_WINDOW"
echo "Alpaca window position: $(alpaca_window_position)"

if [[ $(alpaca_window_position) -le 70 ]]; then
  hyprctl dispatch focuswindow "$ALPACA_WINDOW"
  hyprctl dispatch swapwindow r
  hyprctl dispatch splitratio 0.5 "$ALPACA_WINDOW"
else
  hyprctl dispatch splitratio 0.5 "$ALPACA_WINDOW"
fi

echo "Custom layout applied successfully."
