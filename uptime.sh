#! /bin/sh -e

while true; do
    uptime_out="$(uptime -p)"
    uptime_out="${uptime_out//up }"
    echo "U   $uptime_out  "
    sleep 60
done
