#!/bin/bash

# Configuration
log_directory="/var/log/httpd" # Change this to your web server's log directory
backup_directory="/backup/logs" # Change this to your desired backup directory
retention_days=7 # Number of days to retain log backups

# Date format for log files
date_format=$(date +"%Y-%m-%d")

# Check if the log directory exists
if [ ! -d "$log_directory" ]; then
    echo "Log directory '$log_directory' does not exist."
    exit 1
fi

# Create the backup directory if it doesn't exist
if [ ! -d "$backup_directory" ]; then
    mkdir -p "$backup_directory"
fi

# Rotate and compress logs
find "$log_directory" -type f -name "*.log" -exec gzip -9 {} \;

# Move rotated logs to the backup directory
mv "$log_directory"/*.log.gz "$backup_directory/"

# Delete log backups older than the retention period
find "$backup_directory" -type f -name "*.log.gz" -mtime +$retention_days -delete

# Optional: Restart your web server to create new log files
# systemctl restart httpd # Uncomment this line if necessary

echo "Log rotation and backup completed."
