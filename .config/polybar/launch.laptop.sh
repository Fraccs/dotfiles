#!/usr/bin/env bash

killall -q polybar

echo "---" | tee -a /tmp/polybar.log

polybar --reload bar &

echo "Bars launched..."
