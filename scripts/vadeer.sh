#!/bin/sh

# INFO: This script is a workaround for using vadeer macro pad on linux
# It identifies the vadeer device and starts reading from it which somehow works

FILES=/dev/hidraw*
for f in $FILES
do
  FILE=${f##*/}
  DEVICE="$(cat /sys/class/hidraw/${FILE}/device/uevent | grep HID_NAME | cut -d '=' -f2)"
  if [ "$DEVICE" = "Vaydeer 9-key Smart Keypad" ]
  then
    printf "%s \t %s \n" $FILE "$DEVICE"
    cat /dev/${FILE} > /dev/null &
  fi
done
