#!/bin/bash

# Stop Tomcat first
sudo systemctl stop tomcat

# Remove the old WAR file
sudo rm -f /opt/tomcat/webapps/hello-world-maven.war

# Remove the unpacked directory if it exists
sudo rm -rf /opt/tomcat/webapps/hello-world-maven

# Optionally clean up any temp files in the work directory (not strictly required)
sudo rm -rf /opt/tomcat/work/*
