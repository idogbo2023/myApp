#!/bin/bash

cpu_threshold=90
mem_threshold=900
disk_threshold=90
netwrk_threshold=1000

  # Get the current usage of CPU and memory
  cpuUsage=$(top -bn1 | awk '/Cpu/ { print $2}')
  memUsage=$(free -m | awk '/Mem/{print $3}')
  diskUsage=$(df -h | awk '$NF=="/"{printf " %d/%dGB (%s)\n", $3,$2,$5}')
  netWork=$(ifstat -n -q 1 1 | awk '{print $1}' | tail -n 1)
  
  #check if thresholds are exceeeded
  # if [ "$cpuUsage" -gt "$cpu_threshold" ] || [ "$memUsage" -gt "$mem_threshold" ] || [ "$diskUsage" -gt "$disk_threshold" ] || [ "$netWork" -gt "$netwrk_threshold" ]; 
# then

  # Print the usage
  echo "CPU Usage: $cpuUsage%"
  echo "Memory Usage: $memUsage MB"
  echo "disk Usage: $diskUsage "
  echo "Network Usage: $netWork "
  echo "{Cpu $cpuUsage},{Memory $memUsage},{Network $netWork},{Disk $diskUsage}" > Metrics.txt
  # fi 
