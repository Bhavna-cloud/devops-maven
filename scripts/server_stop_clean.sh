#!/bin/bash

# Stop Tomcat
sudo systemctl stop tomcat

# Ensure the backup directory exists in S3
aws s3 ls s3://mydatabucket03/backup/ || aws s3 mb s3://mydatabucket03/backup/

# Get the current date and time (YYYYMMDD-HHMMSS)
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

# Move WAR file to S3 with a timestamp
if [ -f "/opt/tomcat/webapps/hello-world-maven.war" ]; then
    aws s3 mv /opt/tomcat/webapps/hello-world-maven.war s3://mydatabucket03/backup/hello-world-maven-$TIMESTAMP.war
    echo "WAR file moved to S3: s3://mydatabucket03/backup/hello-world-maven-$TIMESTAMP.war"
else
    echo "No WAR file found to move."
fi
