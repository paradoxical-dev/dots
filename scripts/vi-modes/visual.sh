#!/bin/sh

mode=$(cat ~/.current_vi_mode)
if [ "$mode" = "v" ]
then 
  exit 0
else
  exit 1
fi

