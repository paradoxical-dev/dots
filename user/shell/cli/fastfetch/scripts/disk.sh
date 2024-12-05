#!/bin/sh

# Get disk usage statistics for the root partition
disk_stats=$(df -h / | awk 'NR==2 {print $3, $2, $5}')

# Parse the output into variables
used=$(echo "$disk_stats" | awk '{print $1}')
total=$(echo "$disk_stats" | awk '{print $2}')
percent=$(echo "$disk_stats" | awk '{print $3}' | tr -d '%')

# Define the maximum length of the progress bar
bar_length=50

# Calculate the number of characters to fill
filled_length=$(( percent * bar_length / 100 ))

filled_bar=$(printf "%0.s─" $(seq 1 $filled_length))
empty_bar=$(printf "%0.s─" $(seq 1 $((bar_length - filled_length))))

# Define colors
GREEN=$(tput setaf 2)  # Green
BLACK=$(tput setaf 0)  # Black (or dark gray)
RESET=$(tput sgr0) 

# Calculate padding to align the percentage
used_free_length=$(( ${#used} + ${#total} + 1 ))  # Combined length of "used/total"
padding=$(( bar_length - used_free_length - ${#percent} - 8 )) # 2 for spaces

# Output the result
printf "%s/%s %${padding}s%s\n" "  /    $used" "$total" "" "${percent}%"
echo "  ${GREEN}$filled_bar${BLACK}$empty_bar${RESET}"
