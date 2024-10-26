#!/usr/bin/env bash

killall -q polybar

echo "---" | tee -a /tmp/polybar.log

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload bar &
  done
else
  polybar --reload bar &
fi

echo "Bars launched..."
