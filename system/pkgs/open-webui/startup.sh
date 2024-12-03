#!/bin/sh

pid=$(ps aux | grep ".open-webui-wrapped serve" | grep -v grep | awk '{print $2}')

if [ -n "$pid" ]; then
  firefox --new-window "http://127.0.0.1:8080"
  exit
else
  notify-send "Open WebUI" "Open WebUI is not running\nCheck the status of open-webui.service"
  exit
fi
