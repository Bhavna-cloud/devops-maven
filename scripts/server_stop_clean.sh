#!/bin/bash

# Stop Tomcat first
sudo systemctl stop tomcat
sudo rm -rf /opt/tomcat/webapps/ROOT.war
