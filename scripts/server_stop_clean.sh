#!/bin/bash

# Stop script on any error
set -e

# Define variables
WAR_FILE="/opt/tomcat/webapps/hello-world-maven.war"
S3_BUCKET="s3://mydatabucket03/backup"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BACKUP_FILE="$S3_BUCKET/hello-world-maven-$TIMESTAMP.war"
LOG_FILE="/var/log/tomcat_backup.log"

# Ensure the log file exists and has correct permissions
if [ ! -f "$LOG_FILE" ]; then
    sudo touch "$LOG_FILE"
    sudo chmod 666 "$LOG_FILE"
fi

# Function to log messages
log_message() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" | tee -a "$LOG_FILE"
}

log_message "Stopping Tomcat service..."
if sudo systemctl stop tomcat; then
    log_message "Tomcat service stopped successfully."
else
    log_message "Warning: Failed to stop Tomcat."
fi

# Check if WAR file exists before backing up
if [ -f "$WAR_FILE" ]; then
    log_message "Backing up WAR file to S3: $BACKUP_FILE"
    
    if aws s3 cp "$WAR_FILE" "$BACKUP_FILE"; then
        log_message "WAR file successfully backed up to S3."
    else
        log_message "Error: Failed to copy WAR file to S3."
        exit 1
    fi
else
    log_message "No WAR file found to back up."
fi

exit 0
