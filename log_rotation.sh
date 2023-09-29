# this line is called a shebang, it specifies the path to the Bash interpreter
#!/bin/bash

# This lines define configuration variables for the script. log_directory specifies the directory where your web server's log files are located. backup_directory
 specifies the directory where backup logs will be stored, retention_days sets the number of days to retain log backups
log_directory="/var/log/httpd"
backup_directory="/backup/logs"
retention_days=7

# DCurrent date in format of yyyy-mm-dd and stores in date_format variable
date_format=$(date +"%Y-%m-%d")

# Check if the specified log directory exists. if it does not, it prints an error message and exit the script with a status code of 1
if [ ! -d "$log_directory" ]; then
    echo "Log directory '$log_directory' does not exist."
    exit 1
fi

# Create if the backup directory exist. if it doesn't, it creates the directory using mkdir
if [ ! -d "$backup_directory" ]; then
    mkdir -p "$backup_directory"
fi

# Uses the find command to locate all files with a log extension in the specified directory, it then uses the -exec option to pass each found file to the gzip -9
command, compressing the log files to maximum
find "$log_directory" -type f -name "*.log" -exec gzip -9 {} \;

# Move all compressed log.gz files from log to backup directory
mv "$log_directory"/*.log.gz "$backup_directory/"

# Delete log backups older than the retention period
find "$backup_directory" -type f -name "*.log.gz" -mtime +$retention_days -delete

# Optional: Restart your web server to create new log files
# systemctl restart httpd

echo "Log rotation and backup completed."
