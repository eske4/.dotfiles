#!/bin/bash

# Check if gammastep is running
if pgrep -x "gammastep" > /dev/null
then
    # If gammastep is running, kill the process
    pkill gammastep
    
else
    # If gammastep is not running, start it
    gammastep -O 2700 &
   
fi
