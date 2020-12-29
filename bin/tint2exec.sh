#!/bin/bash

#VPN
FILE=/proc/sys/net/ipv4/conf/proton0
if [ -d "$FILE" ]; then
    vpn_str=""
else 
    vpn_str=""
fi

#CPU
read cpu a b c previdle rest < /proc/stat
prevtotal=$((a+b+c+previdle))
sleep 0.5
read cpu a b c idle rest < /proc/stat
total=$((a+b+c+idle))
cpu_str=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))

#RAM
ram_str=$(free | awk '/Mem/ {printf "%d MiB\n", $3 / 1024.0, $2 / 1024.0 }')

echo "VPN   $vpn_str       $cpu_str       $ram_str"
