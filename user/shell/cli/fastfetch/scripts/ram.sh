#!/bin/sh

# Get memory usage statistics
mem_stats=$(free -h | awk 'NR==2 {print $3, $2, $6, $3/$2*100}')
swap_stats=$(free -h | awk 'NR==3 {print $3, $2, $3/$2*100}')

# Parse the output into variables and strip out the units (Gi, G, etc.)
used_mem=$(echo "$mem_stats" | awk '{print $1}' | sed 's/[A-Za-z]//g')
total_mem=$(echo "$mem_stats" | awk '{print $2}' | sed 's/[A-Za-z]//g')
cached_mem=$(echo "$mem_stats" | awk '{print $3}' | sed 's/[A-Za-z]//g')
percent_mem=$(echo "$mem_stats" | awk '{print $4}' | tr -d '%')

used_swap=$(echo "$swap_stats" | awk '{print $1}' | sed 's/[A-Za-z]//g')
total_swap=$(echo "$swap_stats" | awk '{print $2}' | sed 's/[A-Za-z]//g')
percent_swap=$(echo "$swap_stats" | awk '{print $3}' | tr -d '%')

# Define the maximum length of the progress bar
bar_length=50

### RAM Bar Calculations ###
used_length_mem=$(echo "scale=0; $percent_mem * $bar_length / 100" | bc)
cached_length=$(echo "scale=0; ($cached_mem * 100 / $total_mem) * $bar_length / 100" | bc)
remaining_length_mem=$(( bar_length - used_length_mem - cached_length ))

filled_used_mem=$(printf "%0.s─" $(seq 1 $used_length_mem))
filled_cached_mem=$(printf "%0.s─" $(seq 1 $cached_length))
empty_mem=$(printf "%0.s─" $(seq 1 $remaining_length_mem))

# Calculate the length of the "used_mem/total_mem" string
used_free_length_mem=$(( ${#used_mem} + ${#total_mem} + 1 ))  # Add 1 for "/"
padding_mem=$(( bar_length - used_free_length_mem - ${#percent_mem} - 10 )) # Subtract for spaces

### Swap Bar Calculations ###
used_length_swap=$(echo "scale=0; $percent_swap * $bar_length / 100" | bc)
remaining_length_swap=$(( bar_length - used_length_swap ))

filled_used_swap=$(printf "%0.s─" $(seq 1 $used_length_swap))
empty_swap=$(printf "%0.s─" $(seq 1 $remaining_length_swap))

# Calculate the length of the "used_swap/total_swap" string
used_free_length_swap=$(( ${#used_swap} + ${#total_swap} + 1 ))  # Add 1 for "/"
padding_swap=$(( bar_length - used_free_length_swap - ${#percent_swap} - 12 )) # Subtract for spaces

# Define colors
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
BLACK=$(tput setaf 0)
RESET=$(tput sgr0)

# Round the percentages for display
rounded_percent_mem=$(echo "scale=1; $percent_mem/1" | bc)
rounded_percent_swap=$(echo "scale=1; $percent_swap/1" | bc)

# Output the RAM result
printf "%s/%s G %${padding_mem}s%s\n" "  RAM    $used_mem" "$total_mem" "" "${rounded_percent_mem}%"
echo "  ${GREEN}$filled_used_mem${BLUE}$filled_cached_mem${BLACK}$empty_mem${RESET}"

# Output the Swap result
printf "%s/%s G %${padding_swap}s%s\n" "  SWAP   $used_swap" "$total_swap" "" "${rounded_percent_swap}%"
if [ "$used_swap" -eq 0 ]; then
  echo "  ${BLACK}$empty_swap${RESET}"
else
  echo "  ${GREEN}$filled_used_swap${BLACK}$empty_swap${RESET}"
fi
