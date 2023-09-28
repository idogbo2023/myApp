#!/bin/bash
# This script monitors CPU and memory usage

while :
do
  # Get the current usage of CPU and memory
  cpuUsage=$(top -bn1 | awk '/Cpu/ { print $2}')
  memUsage=$(free -m | awk '/Mem/{print $3}')
  diskUsage=$(df -h | awk '$NF=="/"{printf " %d/%dGB (%s)\n", $3,$2,$5}')
  netWork=$(iftop -t -s 2 | awk '/Mem/{print $2}')
  # Print the usage
  echo "CPU Usage: $cpuUsage%"
  echo "Memory Usage: $memUsage MB"
  echo "disk Usage: $diskUsage "
  echo "network: $netWork "

  # Sleep for 1 second
  sleep 1
done

