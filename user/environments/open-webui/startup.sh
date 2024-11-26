#!/bin/sh

# capture running open-webui process
pid=$(ps aux | grep "open-webui serve" | grep -v grep | awk '{print $2}')

if [ -n "$pid" ]; then
  echo "Found open-webui serve process: $pid"
  firefox --new-window http://127.0.0.1:8080
else
  echo "No open-webui serve process found."
  notify-send "Starting open-webui" "No server open.\nThis will take awhile..."
  cd ~/open-webui/
  nix develop . --command sh -c "venv/bin/python3 venv/bin/open-webui serve & disown"
  firefox --new-window http://127.0.0.1:8080
fi

