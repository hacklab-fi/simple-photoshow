#!/bin/bash

ISFEH=$(pidof feh)
echo $ISFEH > /home/pi/Documents/tsek.log
if [ "$ISFEH" = "" ]; then
   echo "Starting photoshow" > /home/pi/Documents/start.log
   export DISPLAY=:0.0
   DISPLAY=:0.0 feh -Y -x -q -D 8 -B black -F -Z -z -r ~/Pictures/
fi
