#!/bin/sh

# set background color based on temperature
set_color() {
  local temp=$1
  # Clean the temperature value (remove non-numeric characters)
  temp=$(echo "$temp" | sed 's/[^0-9.]//g')

  # Check if the temperature is valid
  if [ -z "$temp" ] || ! echo "$temp" | grep -qE '^[0-9]+(\.[0-9]+)?$'; then
    # If no temperature is available, print "N/A"
    echo "N/A"
  elif (( $(echo "$temp <= 50" | bc -l) )); then
    # Green background for <= 50
    echo "$(tput setab 2) $temp°C $(tput sgr0)"
  elif (( $(echo "$temp <= 75" | bc -l) )); then
    # Yellow background for 51-75
    echo "$(tput setab 3) $temp°C $(tput sgr0)"
  else
    # Red background for > 75
    echo "$(tput setab 1) $temp°C $(tput sgr0)"
  fi
}

# Retrieve the temperatures
cpu_temp=$(sensors | grep 'Tctl' | awk '{print $2}' | sed 's/[^0-9.]//g')
dgpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
igpu_temp=$(sensors | grep 'edge' | awk '{print $2}' | sed 's/[^0-9.]//g')
ssd_temp=$(sensors | grep 'Composite' | awk '{print $2}' | sed 's/[^0-9.]//g')

# Print temp blocks with a check to ensure valid readings
echo "CPU: $cpu_temp"
echo "dGPU: $dgpu_temp"
echo "iGPU: $igpu_temp"
echo "SSD: $ssd_temp"
echo "CPU: $(set_color "$cpu_temp")"
echo "dGPU: $(set_color "$dgpu_temp")"
echo "iGPU: $(set_color "$igpu_temp")"
echo "SSD: $(set_color "$ssd_temp")"
