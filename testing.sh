#!/bin/bash

# Define thresholds (adjust these values as needed)
CPU_THRESHOLD=80
MEMORY_THRESHOLD=90
DISK_THRESHOLD=90
NETWORK_THRESHOLD=1000 # You can set the threshold in KB/s

# Get current date and time
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Monitor CPU utilization
CPU_UTILIZATION=$(top -b -n 1 | grep "%Cpu(s)" | awk '{print $2}' | cut -d. -f1)

# Monitor Memory utilization
MEMORY_UTILIZATION=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d. -f1)

# Monitor Disk utilization
DISK_UTILIZATION=$(df -h / | awk 'NR==2{print $5}' | cut -d% -f1)

# Monitor Network utilization (assuming eth0 interface)
NETWORK_UTILIZATION=$(ifstat -n -q 1 1 | awk '{print $1}' | tail -n 1)

# Check if thresholds are exceeded and log to Metrics.txt
if [ "$CPU_UTILIZATION" -gt "$CPU_THRESHOLD" ] || [ "$MEMORY_UTILIZATION" -gt "$MEMORY_THRESHOLD" ] || [ "$DISK_UTILIZATION" -gt "$DISK_THRESHOLD" ] || [ "$NETWORK_UTILIZATION" -gt "$NETWORK_THRESHOLD" ]; then
    echo "Timestamp: $TIMESTAMP" >> /var/log/Metrics.txt
    echo "CPU Utilization: $CPU_UTILIZATION%" >> /var/log/Metrics.txt
    echo "Memory Utilization: $MEMORY_UTILIZATION%" >> /var/log/Metrics.txt
    echo "Disk Utilization: $DISK_UTILIZATION%" >> /var/log/Metrics.txt
    echo "Network Utilization: $NETWORK_UTILIZATION KB/s" >> /var/log/Metrics.txt
    echo "-----------------------------------------" >> /var/log/Metrics.txt
fi
