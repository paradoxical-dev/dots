#!/bin/sh

pid=$(ps aux | grep ".open-webui-wrapped serve" | grep -v grep | awk '{print $2}')

if [ -n "$pid" ]; then
  firefox --new-window "http://localhost:8080"
else
  notify-send "Open WebUI" "Open WebUI is not running\nCheck the status of open-webui.service"
fi
