#!/bin/sh

if ! command -v docker &> /dev/null; then
  echo "Error: Docker not found."
  exit 1
fi

format_ports() {
  ports_json=$1
  echo "$ports_json" | jq -r '
    to_entries[] | 
    "\(.key) -> \(.value[0].HostIp):\(.value[0].HostPort)"
  '
}

get_container_info() {
  container_name=$1
  container_id=$(docker inspect --format '{{.ID}}' "$container_name" 2>/dev/null)
  if [ -z "$container_id" ]; then
    echo "Container '$container_name' not found."
    return 1
  fi

  info=$(docker inspect --format="{{json .}}" "$container_name")
  status=$(echo "$info" | jq -r '.State.Status')
  ports_json=$(echo "$info" | jq -r '.NetworkSettings.Ports')
  ports=$(format_ports "$ports_json")
}

get_status_symbol() {
  status=$1
  if [ "$status" = "running" ]; then
    echo -e "\033[32m●\033[0m"
  elif [ "$status" = "paused" ]; then
    echo -e "\033[33m\033[0m"
  elif [ "$status" = "exited" ]; then
    echo -e "\033[31m\033[0m"
  else
    echo -e "\033[34m?  $1\033[0m"
  fi
}

main() {
  if [ $# -eq 0 ]; then
    echo "Error: No container name provided."
    exit 1
  fi

  echo "  |  Name   |   Status   |   Ports  |"
  echo "  ───────────────────────────────────"
  for container_name in "$@"; do
    get_container_info "$container_name" || continue
    echo -e "  \033[1m$container_name\033[0m\t  $(get_status_symbol "$status")\t     \033[3;35m$ports\033[0m"
  done
}

main "$@"
