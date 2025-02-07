
#!/bin/sh

mode=$(cat ~/.current_vi_mode)
if [ "$mode" = "vl" ]
then 
  exit 0
else
  exit 1
fi

